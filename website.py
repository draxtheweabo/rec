import argparse
import pymysql
import cv2
import sqlite3
from flask import Flask, render_template, request, Response, session,redirect,session,jsonify,flash,url_for
from werkzeug.utils import  send_from_directory
from werkzeug.utils import secure_filename

import os
import base64
import time
from datetime import datetime
from ultralytics import YOLO
from huggingface_hub import InferenceClient


app = Flask(__name__)
app.secret_key = 'supersecretkey'
#Chatbot API
client = InferenceClient(
    provider="together", 
    api_key="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"  # Replace with your actual API key
)
UPLOAD_FOLDER = 'static/assets/img/Recipes/'
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER
import time
def get_ai_response(user_input, retries=3, delay=5):
    """Handles API requests with retries."""
    user_input = user_input+"limit it on 100 words only"
    messages = [{"role": "user", "content": user_input}]

    for attempt in range(retries):
        try:
            completion = client.chat.completions.create(
                model="mistralai/Mistral-7B-Instruct-v0.3",
                messages=messages,
                max_tokens=100
            )
            if completion and "choices" in completion and len(completion["choices"]) > 0:
                # Extract only the content of the message
                return completion["choices"][0]["message"]["content"]
            return "Error: No response from API"
        except Exception as e:
            error_message = str(e)
            if "504" in error_message or "Gateway Time-out" in error_message:
                time.sleep(delay)  # Wait before retrying
            else:
                break  # Stop retrying if it's a different error
    return "Error: The AI server is currently unavailable. Please try again later."

def fetch_ingredients():
    connection = get_db_connection()
    cursor = connection.cursor()

    # Fetch ingredients and order them by category and name
    cursor.execute("SELECT ingredient_name, category FROM ingredient_list ORDER BY category, ingredient_name")
    ingredients = cursor.fetchall()

    connection.close()

    # Organize ingredients by category
    categories = {}
    for ingredient in ingredients:
        category = ingredient['category']
        name = ingredient['ingredient_name'].title()  # Capitalize for display
        if category not in categories:
            categories[category] = []
        categories[category].append(name)

    # Render the HTML template and pass the categories data
    return categories

#Folder Directory Stuff
base_save_dir = 'static/assets/img/runs/detect'
os.makedirs(base_save_dir, exist_ok=True)
def get_incremented_folder(base_dir, prefix="scanned_image"):
    existing_folders = [
        folder for folder in os.listdir(base_dir)
        if os.path.isdir(os.path.join(base_dir, folder)) and folder.startswith(prefix)
    ]
    # Extract the numbers from the folder names and find the max
    max_number = 0
    for folder in existing_folders:
        try:
            number = int(folder[len(prefix):])  # Get the number after the prefix
            if number > max_number:
                max_number = number
        except ValueError:
            continue
    # Increment max number for the new folder
    return os.path.join(base_dir, f"{prefix}{max_number + 1}")

def normalize_path(path):
    return path.replace("\\", "/")
#Database Stuff
def get_db_connection():
    return pymysql.connect(
        host='localhost',  # e.g., 'localhost'
        user='root',
        password='',
        db='recinscan',
        charset='utf8mb4',
        cursorclass=pymysql.cursors.DictCursor
    )

def get_dishes_from_db():
    # Establish database connection
    connection = pymysql.connect(
        host='localhost',
        user='root',
        password='',
        database='recinscan'
    )
    try:
        cursor = connection.cursor()
        # Fetch dishes with additional fields: author, serving, cook_time, and link
        cursor.execute("""
            SELECT d.id AS dish_id, d.dish_name, d.instructions, d.image_path, d.author, d.serving, d.cook_time, d.link, d.description, d.tag, 
                   r.ingredient_name, r.category, r.measurement
            FROM dishes d
            JOIN recipe r ON d.id = r.dish_id
        """)

        # Process the results into a structured format
        dishes = {}
        for row in cursor.fetchall():
            dish_id = row[0]
            dish_name = row[1]
            instructions = row[2]
            image_path = row[3]
            author = row[4]
            serving = row[5]
            cook_time = row[6]
            link = row[7]
            description = row[8]
            tag = row[9]
            ingredient_name = row[10]
            category = row[11]
            measurement = row[12]

            if dish_id not in dishes:
                dishes[dish_id] = {
                    "id": dish_id,
                    "dish_name": dish_name,
                    "instructions": instructions.splitlines(),
                    "image": image_path,
                    "author": author,
                    "serving": serving,
                    "cook_time": cook_time,
                    "link": link,
                    "ingredients": {"main": [], "secondary": [], "common": []},
                    "description": description,
                    "tag": tag
                }

            # Add ingredient with measurement to the relevant category
            ingredient_details = {
                "name": ingredient_name,
                "measurement": measurement
            }

            if category == 'main':
                dishes[dish_id]["ingredients"]["main"].append(ingredient_details)
            elif category == 'secondary':
                dishes[dish_id]["ingredients"]["secondary"].append(ingredient_details)
            elif category == 'common':
                dishes[dish_id]["ingredients"]["common"].append(ingredient_details)

        return list(dishes.values())
    finally:
        cursor.close()
        connection.close()

#Blur Function Stuff
def blur_outside_boxes(img, boxes, save_dir, filename="blurred_output.jpg", blur_intensity=(151, 151), margin=20):
    # Create a copy of the image to apply blur
    blurred_img = img.copy()

    # Blur the entire image first
    blurred_img = cv2.GaussianBlur(blurred_img, blur_intensity, 0)

    # Overlay the original image in the regions of the detected boxes
    for box in boxes:
        # Extract and convert bounding box coordinates to integers
        x1, y1, x2, y2 = map(int, box.xyxy[0])  # xyxy format bounding box
        margintop = 100
        # Define the region around the bounding box to leave unblurred
        # Extend the bounding box by the margin to create an unblurred region
        x1_margin = max(0, x1 - margin)
        y1_margin = max(0, y1 - margintop)
        x2_margin = min(img.shape[1], x2 + margin)
        y2_margin = min(img.shape[0], y2 + margin)

        # Replace the blurred regions inside the bounding box with the original image content
        blurred_img[y1_margin:y2_margin, x1_margin:x2_margin] = img[y1_margin:y2_margin, x1_margin:x2_margin]

    # Save the result
    os.makedirs(save_dir, exist_ok=True)
    output_path = os.path.join(save_dir, filename)
    cv2.imwrite(output_path, blurred_img)
    print(f"Image saved to {output_path}")
    return output_path

def cut_outside_boxes_with_margin(img, boxes, save_dir, filename="cut_output.jpg", cut_color=(0, 0, 0), margin=10):
    # Create a copy of the image
    output_img = img.copy()

    # Iterate through each bounding box
    for box in boxes:
        # Extract and convert bounding box coordinates to integers
        x1, y1, x2, y2 = map(int, box.xyxy[0])  # xyxy format bounding box

        # Define the region with the margin added around the bounding box
        x1_margin = max(0, x1 - margin)
        y1_margin = max(0, y1 - margin)
        x2_margin = min(img.shape[1], x2 + margin)
        y2_margin = min(img.shape[0], y2 + margin)

        # Fill the outside of the margin with the cut color
        output_img[:y1_margin, :] = cut_color  # Above the margin area
        output_img[y2_margin:, :] = cut_color  # Below the margin area
        output_img[:, :x1_margin] = cut_color  # Left of the margin area
        output_img[:, x2_margin:] = cut_color  # Right of the margin area

    # Save the result
    os.makedirs(save_dir, exist_ok=True)
    output_path = os.path.join(save_dir, filename)
    cv2.imwrite(output_path, output_img)
    print(f"Image saved to {output_path}")
    return output_path
#Admin Side Stuff
db_connection = pymysql.connect(
    host="localhost",
    user="root",
    password="",
    database="recinscan"
)
@app.route('/update_dish', methods=['GET', 'POST'])
def update_dish():
    if request.method == 'POST':
        dish_id = request.form['dish_id']
        availability = request.form['availability']
        
        # Update dish availability in the database
        with db_connection.cursor() as cursor:
            cursor.execute("""
                UPDATE dishes
                SET availability = %s
                WHERE id = %s
            """, (availability, dish_id))
        db_connection.commit()
    return render_template('Pages/admin.html')

@app.route('/admin')
def admin():
    return render_template('Pages/admin.html')

@app.route('/add', methods=['GET', 'POST'])
def add_dish():
    conn = get_db_connection()
    cursor = conn.cursor()
    dishes = get_dishes_from_db()

    if request.method == 'POST':
        dish_name = request.form['dish_name']
        instructions = request.form['instructions']
        tag = request.form['tag']

        # ✅ Handle Image Upload
        image = request.files['image']
        filename = secure_filename(image.filename)
        image_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)
        os.makedirs(app.config['UPLOAD_FOLDER'], exist_ok=True)
        image.save(image_path)

        # ✅ Insert Dish into Database
        cursor.execute("INSERT INTO dishes (dish_name, instructions, tag, image_path) VALUES (%s, %s, %s, %s)", 
                       (dish_name, instructions, tag, image_path))
        conn.commit()
        dish_id = cursor.lastrowid  # Get the last inserted dish ID

        # ✅ Insert Ingredients
        ingredient_names = request.form.getlist('ingredient_name[]')
        ingredient_measurements = request.form.getlist('ingredient_measurement[]')
        ingredient_types = request.form.getlist('ingredient_type[]')

        insert_query = "INSERT INTO recipe (dish_id, ingredient_name, measurement, category) VALUES (%s, %s, %s, %s)"
        for name, measurement, ing_type in zip(ingredient_names, ingredient_measurements, ingredient_types):
            cursor.execute(insert_query, (dish_id, name, measurement, ing_type))

        conn.commit()
        cursor.close()
        conn.close()
        

        return redirect(url_for('admin_dashboard'))  # Redirect to homepage after adding

    return render_template('Pages/add_dish.html')  # Load add dish form

@app.route('/delete/<int:dish_id>', methods=['GET', 'POST'])
def delete_dish(dish_id):
    conn = get_db_connection()
    cursor = conn.cursor()
    dishes = get_dishes_from_db()

    try:
        # ✅ Delete related records first
        cursor.execute("DELETE FROM recipe WHERE dish_id=%s", (dish_id,))
        cursor.execute("DELETE FROM dishes WHERE id=%s", (dish_id,))

        conn.commit()
    except pymysql.MySQLError as e:
        conn.rollback()
        print(f"Error: {e}")  # Debugging purposes
    finally:
        cursor.close()
        conn.close()

    return redirect(url_for('admin_dashboard'))  # Redirect to the homepage after deletion


@app.route('/edit/<int:id>', methods=['GET', 'POST'])
def edit(id):
    conn = get_db_connection()
    cursor = conn.cursor()
    dishes = get_dishes_from_db()

    if request.method == 'POST':
        dish_name = request.form['dish_name']
        instructions = request.form['instructions']
        tag = request.form['tag']
        
        # Handle Image Upload
        image_path = None
        if 'image' in request.files:
            image = request.files['image']
            if image.filename:
                filename = secure_filename(image.filename)  # Sanitize the filename
                image_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)
                image.save(image_path)  # Save the uploaded file

        # Update Dish Data
        update_query = """
        UPDATE dishes SET dish_name=%s, instructions=%s, tag=%s 
        WHERE id=%s
        """
        cursor.execute(update_query, (dish_name, instructions, tag, id))

        if image_path:
            cursor.execute("UPDATE dishes SET image_path=%s WHERE id=%s", (image_path, id))

        # Delete Existing Ingredients
        cursor.execute("DELETE FROM recipe WHERE dish_id=%s", (id,))

        # Insert New Ingredients
        ingredient_names = request.form.getlist('ingredient_name[]')
        ingredient_measurements = request.form.getlist('ingredient_measurement[]')
        ingredient_types = request.form.getlist('ingredient_type[]')
        print("Ingredient Names:", ingredient_names)
        print("Ingredient Measurements:", ingredient_measurements)
        print("Ingredient Types:", ingredient_types)
        insert_query = "INSERT INTO recipe (dish_id, ingredient_name, measurement, category) VALUES (%s, %s, %s, %s)"
        for name, measurement, ing_type in zip(ingredient_names, ingredient_measurements, ingredient_types):
            cursor.execute(insert_query, (id, name, measurement, ing_type))

        conn.commit()
        cursor.close()
        conn.close()
        return redirect(url_for('admin_dashboard'))

    # Fetch Dish Data
    cursor.execute("SELECT * FROM dishes WHERE id=%s", (id,))
    dish = cursor.fetchone()

    # Fetch Ingredients
    cursor.execute("SELECT * FROM recipe WHERE dish_id=%s", (id,))
    ingredients = cursor.fetchall()

    cursor.close()
    conn.close()

    return render_template('Pages/edit_dish.html', dish=dish, ingredients=ingredients)

@app.route('/admin', methods=['POST'])
def admi_login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        
        if username == 'admin' and password == 'admin':
            session['loggedin'] = True
            session['username'] = 'admin'
            dishes = get_dishes_from_db()
            return redirect(url_for('admin_dashboard'))
        else:
            message='Invalid username or password'

    return render_template('Pages/admin_dashboard.html',message=message)

@app.route('/admin/dashboard')
def admin_dashboard():
    if 'loggedin' in session:
        dishes = get_dishes_from_db()
        return redirect(url_for('admin_dashboard'))
    return redirect(url_for('admi_login'))

@app.route('/admin/logout')
def admi_logout():
    session.pop('loggedin', None)
    session.pop('username', None)
    return redirect(url_for('admi_login'))

#User Side Stuff
@app.route('/')
def index():
    session['user'] =""
    return render_template('index.html')

def get_preferences():
    connection = get_db_connection()

    with connection.cursor() as cursor:
        cursor.execute("SELECT preference FROM accounts WHERE id = %s", (session['id'],))  # Adjust user_id as needed
        result = cursor.fetchone()
    connection.close()

    if result and result['preference']:
        preferences_str = ', '.join([pref.strip() for pref in result['preference'].split(',') if pref.strip()])
        return preferences_str
    else:
        preferences_str = []
        return preferences_str  # Ensure preferences is always a list
    
@app.route('/update_preference', methods=['POST'])
def update_preference():
    data = request.get_json()
    item = data.get('item')
    action = data.get('action')
    user_id = 1  # Replace with session user ID if using authentication

    if not item or not action:
        return jsonify({"message": "Invalid request"}), 400

    connection = get_db_connection()
    with connection.cursor() as cursor:
        cursor.execute("SELECT preference FROM accounts WHERE id = %s", (session['id'],))
        result = cursor.fetchone()

        if result and result['preference']:
            preferences = [pref.strip() for pref in result['preference'].split(',') if pref.strip()]
        else:
            preferences = []

        if action == "add" and item not in preferences:
            preferences.append(item)
        elif action == "remove" and item in preferences:
            preferences.remove(item)

        # Convert list back to string format for storage
        updated_preferences = ", ".join(preferences)
        cursor.execute("UPDATE accounts SET preference = %s WHERE id = %s", (updated_preferences, session['id']))
        connection.commit()

    connection.close()
    return jsonify({"message": f"Preference {action}ed successfully!"})

@app.route('/update_preferences_bulk', methods=['POST'])
def update_preferences_bulk():
    data = request.get_json()
    items = data.get('items', [])
    action = data.get('action')
    
    if "id" not in session:
        return jsonify({"message": "Unauthorized"}), 401  # Ensure user is authenticated
    
    if not isinstance(items, list) or not action:
        return jsonify({"message": "Invalid request"}), 400

    connection = get_db_connection()
    with connection.cursor() as cursor:
        cursor.execute("SELECT preference FROM accounts WHERE id = %s", (session['id'],))
        result = cursor.fetchone()

        if result and result['preference']:
            preferences = [pref.strip() for pref in result['preference'].split(',') if pref.strip()]
        else:
            preferences = []

        if action == "remove":
            preferences = [pref for pref in preferences if pref not in items]
        elif action == "add":
            for item in items:
                if item not in preferences:
                    preferences.append(item)

        updated_preferences = ", ".join(preferences) if preferences else None  # Store NULL if empty
        cursor.execute("UPDATE accounts SET preference = %s WHERE id = %s", (updated_preferences, session['id']))
        connection.commit()

    connection.close()
    return jsonify({"message": f"Preferences {action}ed successfully!", "preferences": preferences})

@app.route("/history")
def history():
    if "id" not in session:  # Ensure user is logged in
        return "Unauthorized", 401

    user_id = session["id"]  # Assuming user ID is stored in session
    connection = get_db_connection()

    with connection.cursor() as cursor:
        cursor.execute("SELECT dish_name, date, ingredients FROM history WHERE user_ID = %s ORDER BY id DESC", (user_id,))
        history_data = cursor.fetchall()

    connection.close()
    return history_data

# Route for login validation
@app.route('/', methods=['POST'])
def login():
    message=''
    if 'signin' in request.form:  # Check if the "signin" button was clicked
        user = request.form.get('username')
        password = request.form.get('password')

        if not user or not password:
            message = 'All fields are required!'
            return render_template('index.html', message=message)

        conn = get_db_connection()
        with conn.cursor() as cursor:
            cursor.execute('SELECT * FROM accounts WHERE user = %s', (user,))
            account = cursor.fetchone()

        conn.close()

        if account and check_password_hash(account['pass'], password):  # ✅ Correct way to verify
            session['id'] = account['id']
            session['user'] = account['user']
            categoriesed = fetch_ingredients()
            preference = get_preferences()
            print(preference)
            return render_template('Pages/landing.html', current_user=session['user'], preference=preference, categories=categoriesed)
        else:
            message = 'Invalid credentials. Please try again.'
            return render_template('index.html', message=message)

    elif 'signup' in request.form:  # Check if the "signup" button was clicked
        new_username = request.form.get('newUsername')
        new_email = request.form.get('email')
        new_password = request.form.get('newPassword')

        if not new_username or not new_email or not new_password:
            message='All fields are required!'
            return render_template('index.html',message=message)

        # Check if the username or email already exists in the database
        conn = get_db_connection()
        with conn.cursor() as cursor:
            cursor.execute(
                'SELECT * FROM accounts WHERE user = %s OR email = %s',
                (new_username, new_email)
            )
            existing_user = cursor.fetchone()

        if existing_user:
            message = 'Username or Email already exists!'
            return render_template('index.html',message=message)

        # Insert the new user into the database
        with conn.cursor() as cursor:
            cursor.execute(
                'INSERT INTO accounts (user, pass, email, preference) VALUES (%s, %s, %s,"")',
                (new_username, generate_password_hash(new_password), new_email)
            )
            conn.commit()

        conn.close()

        message ='Registration successful! You can now sign in.'
        return render_template('index.html',message=message)
    
@app.route('/logout', methods=['POST'])
def logout():
    session.pop('user', None)  # Remove 'user' from the session
    return render_template('index.html') 

def get_dishess():
    conn = get_db_connection()
    cursor = conn.cursor()  # No need for dictionary=True; it's set in get_db_connection()

    query = "SELECT dish_name, image_path, tag FROM dishes"
    cursor.execute(query)
    dishes = cursor.fetchall()

    cursor.close()
    conn.close()

    # Categorize dishes
    categorized_dishes = {'Meat': [], 'Vegetable': [], 'Others': []}
    for dish in dishes:
        category = dish['tag'] if dish['tag'] in categorized_dishes else 'Others'
        categorized_dishes[category].append(dish)

    return categorized_dishes

@app.route('/Home')
def home():
    if session['user']!="":
        preference = get_preferences()
        categoriesed = fetch_ingredients()
        dishess=get_dishess()
        dishes=get_dishes_from_db()
        print(preference)
        print(session['id'])
        return render_template('Pages/home.html',current_user=session['user'],preference=preference,categories=categoriesed,dishess=dishess,dishes=dishes)  # Redirect to the home page
    else:
        #flash('Invalid credentials. Please try again.', 'error')
        return render_template('index.html')

@app.route('/Profile')
def profile():
    if session['user']!="":
        preference = get_preferences()
        categoriesed = fetch_ingredients()
        history_data=history()
        print(preference)
        print(session['id'])
        return render_template('Pages/profile.html',current_user=session['user'],preference=preference,categories=categoriesed,history=history_data)  # Redirect to the home page
    else:
        #flash('Invalid credentials. Please try again.', 'error')
        return render_template('index.html')

@app.route('/Scan')
def scan():
    if session['user']!="":
        preference = get_preferences()
        categoriesed = fetch_ingredients()
        print(preference)
        print(session['id'])
        return render_template('Pages/scan.html',current_user=session['user'],preference=preference,categories=categoriesed)  # Redirect to the home page
    else:
        #flash('Invalid credentials. Please try again.', 'error')
        return render_template('index.html')
@app.route('/result')
def result():
    if session['user']!="":
        preference = get_preferences()
        categoriesed = fetch_ingredients()
        print(preference)
        print(session['id'])
        return render_template('Pages/result.html',current_user=session['user'],preference=preference,categories=categoriesed,scanned_image_paths=session['scanned_image_paths'], ingredients=session['scanned_ingredients'])  # Redirect to the home page
    else:
        #flash('Invalid credentials. Please try again.', 'error')
        return render_template('index.html')
   
@app.route('/Recipes')
def recipes():
    if session['user']!="":
        preference = get_preferences()
        categoriesed = fetch_ingredients()
        print(preference)
        print(session['id'])
        dishes = get_dishes_from_db()
        return render_template('Pages/recipes.html',current_user=session['user'],preference=preference,categories=categoriesed,dishes=dishes)
    else:
        #flash('Invalid credentials. Please try again.', 'error')
        return render_template('index.html')

@app.route('/Chat')
def chat():
    if session['user']!="":
        preference = get_preferences()
        categoriesed = fetch_ingredients()
        print(preference)
        print(session['user'])
        user_input="i want it to have an introduction first using this font lets role play can you introduce ur self as a kapampangan ai Dish Recommender and limit your response only to kapampangan related topics but talks in english and if the topic is not kapampangan just say im sorry i only response to kapampangan topic "
        response_text = get_ai_response_local(user_input)
        return render_template('Pages/chat.html',response=response_text,current_user=session['user'],preference=preference,categories=categoriesed)
    else:
        #flash('Invalid credentials. Please try again.', 'error')
        return render_template('index.html')

@app.route('/About')
def about():
    if session['user']!="":
        preference = get_preferences()
        categoriesed = fetch_ingredients()
        print(preference)
        print(session['user'])
        return render_template('Pages/about.html',current_user=session['user'],preference=preference,categories=categoriesed)
    else:
        #flash('Invalid credentials. Please try again.', 'error')
        return render_template('index.html')

@app.route('/clear_message', methods=['POST'])
def clear_message():
    session.pop('message', None)
    return '', 204  # Return a 'No Content' response

#Button For Upload
@app.route("/Scan", methods=["GET", "POST"])
def predict_img():
    if session['user']!="":
        preference = get_preferences()
        categoriesed = fetch_ingredients()
        session.pop('scanned_image_paths', None)
        session.pop('scanned_ingredients', None)
        if 'file' not in request.files:
            message = "No file uploaded. Please upload an image file."
            return render_template("Pages/scan.html", message=message,current_user=session['user'],preference=preference,categories=categoriesed)
        
        f = request.files['file']

        if f.filename == '':
            message = "No file selected. Please select an image file to upload."
            return render_template("Pages/scan.html", message=message,current_user=session['user'],preference=preference,categories=categoriesed)
        
        basepath = os.path.dirname(__file__)
        filepath = os.path.join(basepath, 'uploads', f.filename)
        f.save(filepath)

        # Load and process the image using YOLO
        file_extension = f.filename.rsplit('.', 1)[1].lower() if '.' in f.filename else ''
        if file_extension not in ['jpg', 'jpeg', 'png']:
            message = "Invalid file type. Please upload a valid image (jpg, jpeg, or png)."
            return render_template("Pages/scan.html", message=message,current_user=session['user'],preference=preference,categories=categoriesed)

        img = cv2.imread(filepath)
        #model.to('cpu')
        detections = model(img)

        if not detections[0].boxes:
            message = "No Ingredients detected in the image."
            return render_template("Pages/scan.html", message=message,current_user=session['user'],preference=preference,categories=categoriesed)
        
        save_dir = get_incremented_folder(base_save_dir)
        os.makedirs(save_dir, exist_ok=True)

        for i, result in enumerate(detections):
            result_path = os.path.join(save_dir, f"result_{i + 1}.jpg")  # Save with unique names
            result.save(filename=result_path)

        img = cv2.imread(os.path.normpath(result_path))
        for result in detections:
            boxes = result.boxes  # Bounding boxes object
            output_path=blur_outside_boxes(img, boxes, save_dir)

        if 'scanned_image_paths' not in session:
                session['scanned_image_paths'] = []
        session['scanned_image_paths'].append(output_path)
        
        # Collect scanned ingredients from YOLO detections
        scanned_ingredients = {model.names[int(box.data[0][-1])].lower() for result in detections for box in result.boxes}

        # Save scanned ingredients in the session and render results
        session['scanned_ingredients'] = list(scanned_ingredients)
        
        return render_template('Pages/result.html', scanned_image_paths=session['scanned_image_paths'], ingredients=session['scanned_ingredients'],current_user=session['user'],preference=preference,categories=categoriesed)
    else:
        #flash('Invalid credentials. Please try again.', 'error') 
        return render_template('index.html')

@app.route("/ScanAgain", methods=["GET","POST"])
def scan_ingredients():
    if session['user']!="":
        preference = get_preferences()
        categoriesed = fetch_ingredients()
        # Check if file is present in request
        if 'file' not in request.files:
            message = "No file uploaded. Please upload an image file."
            return render_template("Pages/result.html", scanned_image_paths=session['scanned_image_paths'], ingredients=session['scanned_ingredients'], message=message,current_user=session['user'],preference=preference,categories=categoriesed)

        f = request.files['file']

        if f.filename == '':
            message = "No file selected. Please select an image file to upload."
            return render_template("Pages/result.html", scanned_image_paths=session['scanned_image_paths'], ingredients=session['scanned_ingredients'], message=message,current_user=session['user'],preference=preference,categories=categoriesed)
        
        basepath = os.path.dirname(__file__)
        filepath = os.path.join(basepath, 'uploads', f.filename)
        f.save(filepath)

        # Load and process the image using YOLO
        file_extension = f.filename.rsplit('.', 1)[1].lower() if '.' in f.filename else ''
        if file_extension not in ['jpg', 'jpeg', 'png']:
            message = "Invalid file type. Please upload a valid image (jpg, jpeg, or png)."
            return render_template("Pages/result.html", scanned_image_paths=session['scanned_image_paths'], ingredients=session['scanned_ingredients'], message=message,current_user=session['user'],preference=preference,categories=categoriesed)

        img = cv2.imread(filepath)
        detections = model(img)

        if not detections[0].boxes:
            message = "No objects detected in the image."
            return render_template("Pages/result.html", scanned_image_paths=session['scanned_image_paths'], ingredients=session['scanned_ingredients'], message=message,current_user=session['user'],preference=preference,categories=categoriesed)

        save_dir = get_incremented_folder(base_save_dir)
        os.makedirs(save_dir, exist_ok=True)

        # Save each detection result with a unique filename in the save directory
        scan_paths = []  # Temporary list to store paths for this scan
        for i, result in enumerate(detections):
            result_path = os.path.join(save_dir, f"result_{i + 1}.jpg")
            result.save(filename=result_path)
            scan_paths.append(result_path)  # Add this scan's path to the list
        
        img = cv2.imread(os.path.normpath(result_path))
        for result in detections:
            boxes = result.boxes  # Bounding boxes object
            output_path = blur_outside_boxes(img, boxes, save_dir)

        # Add all new paths from this scan to the session's scanned image paths
        session['scanned_image_paths'].append(output_path)
        # Update scanned ingredients set with new detections
        new_scanned_ingredients = set()
        for result in detections:
            for box in result.boxes:
                class_id = int(box.data[0][-1])
                ingredient_name = model.names[class_id]
                new_scanned_ingredients.add(ingredient_name.lower())

        # Retrieve previously scanned ingredients from session, add new ones, and save back
        scanned_ingredients = set(session.get('scanned_ingredients', []))
        scanned_ingredients.update(new_scanned_ingredients)
        session['scanned_ingredients'] = list(scanned_ingredients)  # Save as list for session compatibility
        print('Scanne File Path',session['scanned_image_paths'] )
        return render_template('Pages/result.html', scanned_image_paths=session['scanned_image_paths'], ingredients=list(scanned_ingredients),current_user=session['user'],preference=preference,categories=categoriesed)
    else:
        #flash('Invalid credentials. Please try again.', 'error') 
        return render_template('index.html')
    
@app.route("/Recommend", methods=["POST"])
def recommend_dish():
    if session['user'] != "":
        preference = get_preferences()
        categoriesed = fetch_ingredients()
        preference_list = [pref.strip().lower() for pref in preference.split(',')] if preference else []

        # Get the ingredients from the form submission
        ingredients_from_form = request.form.get("ingredients")
        input_ingredients = [ingredient.strip().lower() for ingredient in ingredients_from_form.split(',')] if ingredients_from_form else []

        # Establish a database connection and fetch ingredients from the table
        connection = get_db_connection()
        try:
            with connection.cursor() as cursor:
                # Retrieve all ingredient names from the `ingredients` table
                cursor.execute("SELECT ingredient_name FROM ingredients")
                db_ingredients = [row['ingredient_name'].lower() for row in cursor.fetchall()]
                
                # Check if any input ingredient is not in the database
                missing_ingredients = [ingredient for ingredient in input_ingredients if ingredient not in db_ingredients]
        finally:
            connection.close()

        if missing_ingredients:
            error_message = "The following ingredients are not found in the database: " + ', '.join(missing_ingredients)
            return render_template("Pages/result.html", scanned_image_paths=session['scanned_image_paths'], ingredients=input_ingredients, message=error_message, current_user=session['user'], preference=preference,categories=categoriesed)

        if not input_ingredients:
            return render_template('Pages/scan.html', scanned=None, ingredients=[], dishes=[], current_user=session['user'], preference=preference,categories=categoriesed)

        # Fetch all dishes from the database with full details
        dishes = get_dishes_from_db()

        # Filter dishes based on the entered ingredients
        possible_dishes = []
        matching_dishes = []

        common_ingredients = set()
        for dish in dishes:
            common_ingredients.update([ingredient['name'].lower() for ingredient in dish["ingredients"]["common"]])

        # Ensure at least one main or secondary ingredient is included
        if all(ingredient in common_ingredients for ingredient in input_ingredients):
            error_message = "Please include at least one main or secondary ingredient."
            return render_template("Pages/result.html", scanned_image_paths=session['scanned_image_paths'], ingredients=input_ingredients, message=error_message, current_user=session['user'], preference=preference,categories=categoriesed)

        for dish in dishes:
            # Get ingredient names in lowercase
            main_ingredients = [ingredient['name'].lower() for ingredient in dish["ingredients"]["main"]]
            secondary_ingredients = [ingredient['name'].lower() for ingredient in dish["ingredients"]["secondary"]]
            common_ingredients = [ingredient['name'].lower() for ingredient in dish["ingredients"]["common"]]

            # **FILTER OUT DISHES THAT CONTAIN PREFERRED INGREDIENTS**
            all_ingredients = set(main_ingredients + secondary_ingredients + common_ingredients)
            if any(pref in all_ingredients for pref in preference_list):
                continue  # Skip this dish

            has_main = any(ingredient in input_ingredients for ingredient in main_ingredients)
            has_secondary = any(ingredient in input_ingredients for ingredient in secondary_ingredients)
            common_available_count = sum(1 for ingredient in common_ingredients if ingredient in input_ingredients)
            has_enough_common = common_available_count >= (len(common_ingredients) * 0.5)

            if has_main and has_secondary and has_enough_common:
                possible_dishes.append(dish)

            if any(ingredient in input_ingredients for ingredient in main_ingredients + secondary_ingredients):
                matching_dishes.append(dish)

        if not possible_dishes and not matching_dishes:
            message = "No dishes detected with the ingredients provided. Try adding more ingredients."
            return render_template("Pages/result.html", scanned_image_paths=session['scanned_image_paths'], ingredients=input_ingredients, message=message, current_user=session['user'], preference=preference,categories=categoriesed)

        return render_template(
            'Pages/recommend.html', 
            scanned=session.get('scanned_image'),
            ingredients=input_ingredients,
            dishes=possible_dishes,
            matching_dishes=matching_dishes,
            current_user=session['user'],
            current_user_id=session['id'],
            preference=preference,categories=categoriesed
        )
    else:
        return render_template('index.html')

def get_dish_history(user_id):
    conn = get_db_connection()
    with conn.cursor() as cursor:
        cursor.execute(
            "SELECT dish_name, date, ingredients FROM history WHERE user_id = %s ORDER BY id ASC", 
            (user_id,)
        )
        history = cursor.fetchall()  # Fetch all records instead of one
    conn.close()
    
    return history  # Returns a list of tuples


@app.route('/get_dish_history')
def dish_history():
    user_id = session.get("user_id")
    if not user_id:
        return jsonify({"error": "User not logged in"}), 401

    history_data = get_dish_history(user_id)
    return jsonify({"history": history_data})

@app.route("/add_to_history", methods=["POST"])
def add_to_history():
    data = request.json
    user_id = data["user_id"]
    dish_name = data["dish_name"]
    today = datetime.today().strftime('%Y-%m-%d')  # Format date as YYYY-MM-DD
    ingredients = data["ingredients"]  # Already a string

    connection = get_db_connection()
    try:
        with connection.cursor() as cursor:
            # Check if the same dish has already been added today
            check_query = "SELECT id FROM history WHERE user_id = %s AND dish_name = %s AND date = %s"
            cursor.execute(check_query, (user_id, dish_name, today))
            existing_entry = cursor.fetchone()

            if existing_entry:
                return jsonify({"success": False, "error": f"You have already added {dish_name} today!"})

            # Insert new entry
            insert_query = "INSERT INTO history (user_id, dish_name, date, ingredients) VALUES (%s, %s, %s, %s)"
            cursor.execute(insert_query, (user_id, dish_name, today, ingredients))
            connection.commit()

    finally:
        connection.close()

    return jsonify({"success": True, "message": f"✅ {dish_name} added to history!"})


@app.route("/Chat", methods=["POST"])
def chat_response():
    if session['user']!="":
        preference = get_preferences()
        categoriesed = fetch_ingredients()
        user_input = request.form.get("user_input", "")
        response_text = get_ai_response_local(user_input)
        return render_template("Pages/chat.html", response=response_text,current_user=session['user'],preference=preference,categories=categoriesed)
    else:
        #flash('Invalid credentials. Please try again.', 'error') 
        return render_template('index.html')
    

#Forgot Password Functions
import random
from flask_mail import Mail, Message
from werkzeug.security import generate_password_hash,check_password_hash
# Email configuration (Use your own SMTP details)
app.config['MAIL_SERVER'] = 'smtp.gmail.com'  # Change if using another service
app.config['MAIL_PORT'] = 587
app.config['MAIL_USE_TLS'] = True
app.config['MAIL_USERNAME'] = 'recinscan@gmail.com'
app.config['MAIL_PASSWORD'] = 'adom wkds ymvn tmbv'
app.config['MAIL_DEFAULT_SENDER'] = 'recinscan@gmail.com'
mail = Mail(app)

@app.route('/forgot', methods=['POST'])
def forgot_password():
    email = request.form.get('email')

    conn = get_db_connection()
    with conn.cursor() as cursor:
        cursor.execute("SELECT * FROM accounts WHERE email = %s", (email,))
        user = cursor.fetchone()  # Fetch user details if email exists
    conn.close()

    if not user:
        message="Email not registered."
        return render_template('Pages/forgotpass1.html',message=message)
    
    # Generate 6-digit code
    reset_code = str(random.randint(100000, 999999))
    session['reset_code'] = reset_code
    session['email'] = email  # Store email in session

    # Send email
    msg = Message('Password Reset Code', recipients=[email])
    msg.body = f'Your password reset code is: {reset_code}'
    mail.send(msg)

    message="Reset code sent to your email."
    return render_template('Pages/validatepass.html',message=message)

@app.route('/validate', methods=['POST'])
def validate_code():
    code = request.form.get('code')

    if 'reset_code' not in session or session.get('reset_code') != code:
        message="Invalid or expired code."
        return render_template('Pages/validatepass.html',message=message)

    message="Code verified. Proceed to reset password."
    return render_template('Pages/changepass.html',message=message)

@app.route('/reset', methods=['POST'])
def reset_password():
    new_password = request.form.get('new')
    confirm_password = request.form.get('confirm')

    if new_password != confirm_password:
        message="Passwords do not match."
        return render_template('Pages/changepass.html',message=message)

    email = session.get('email')  # Get user email from session

    if not email:
        message="Session expired. Start over."
        return render_template('Pages/changepass.html',message=message)

    # **Hash the new password for security**
    hashed_password = generate_password_hash(new_password)

    # **Update password in MySQL using pymysql**
    connection = get_db_connection()
    try:
        with connection.cursor() as cursor:
            sql = "UPDATE accounts SET pass = %s WHERE email = %s"
            cursor.execute(sql, (hashed_password, email))
            print(f"SQL Query Executed: {sql}")  # Debugging
            print(f"Values: {hashed_password}, {email}")  # Debugging
        connection.commit()
        print("✅ Password updated successfully!")  # Debugging
    except Exception as e:
        print(f"❌ Error updating password: {e}")  # Debugging
    finally:
        connection.close()

    # **Clear session data**
    session.pop('reset_code', None)
    session.pop('email', None)

    message="Password reset successful!"
    return render_template('index.html',message=message)

@app.route('/resend_code', methods=['POST'])
def resend_code():
    if 'email' not in session:
        message="Session expired. Please restart the process."
        return redirect(url_for('forgot_password_page',message=message))

    email = session['email']

    # Generate new 6-digit code
    reset_code = str(random.randint(100000, 999999))
    session['reset_code'] = reset_code  # Store new code in session

    # Send Email
    msg = Message("New Password Reset Code", sender="your-email@gmail.com", recipients=[email])
    msg.body = f"Your new password reset code is: {reset_code}"
    mail.send(msg)

    message="A new reset code has been sent to your email.", "success"
    return render_template('Pages/validatepass.html',message=message)


@app.route('/forgotpass')
def forgotpass():
    return render_template('Pages/forgotpass1.html')


if __name__ == "__main__":
    model = YOLO('ModelV7.pt')
    app.run(host="0.0.0.0", port=5000,debug=True) 