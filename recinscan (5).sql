-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 16, 2025 at 04:42 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `recinscan`
--

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE `accounts` (
  `id` int(11) NOT NULL,
  `user` varchar(255) NOT NULL,
  `pass` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `preference` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `accounts`
--

INSERT INTO `accounts` (`id`, `user`, `pass`, `email`, `preference`) VALUES
(1, 'edward', 'edward123', 'draxtheweabo02@gmail.com', '');

-- --------------------------------------------------------

--
-- Table structure for table `dishes`
--

CREATE TABLE `dishes` (
  `id` int(11) NOT NULL,
  `dish_name` varchar(255) NOT NULL,
  `instructions` text DEFAULT NULL,
  `image_path` varchar(255) NOT NULL,
  `author` varchar(255) DEFAULT NULL,
  `link` varchar(255) DEFAULT NULL,
  `serving` varchar(50) DEFAULT NULL,
  `cook_time` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `tag` enum('Meat','Vegetable','Others') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dishes`
--

INSERT INTO `dishes` (`id`, `dish_name`, `instructions`, `image_path`, `author`, `link`, `serving`, `cook_time`, `description`, `tag`) VALUES
(1, 'Sisig Kapampangan Style With (Pork Belly)', 'Step 1: Marinate the pork belly slices with salt and pepper. Let it sit for at least 30 minutes.\nStep 2: Grill the pork belly and chicken liver until well done. Ensure the pork skin is crispy.\nStep 3: Once grilled, chop the pork belly and chicken liver into small fine pieces.\nStep 4: In a bowl, combine the chopped meat, onions, lemon juice, and chili pepper. Season with soy sauce and pepper.\nStep 5: Warm the mixture in a pan with a bit of oil if desired.\nStep 6: Alternatively, heat a sizzling plate and add some butter or margarine.\nStep 7: Add the Sisig and serve while still sizzling hot.', '/static/assets/img/Recipes/recipe1.jpg', 'Bebs', 'https://www.foxyfolksy.com/sisig-recipe-using-pork-belly/', '4 people', '30 mins', 'A sizzling Kapampangan dish made from pork parts, usually served with calamansi and chili.', 'Meat'),
(2, 'Sisig Kapampangan Style With (Pork Parts)', 'Step 1: Finely chop the grilled pork parts and set aside.\nStep 2: Finely chop the grilled chicken liver. (You may also use a food processor.)\nStep 3: In a large bowl, combine the finely chopped grilled pork parts and chicken liver.\nStep 4: Add the onions, chili, and calamansi juice. Add more calamansi juice if you want it more sour.\nStep 5: Season with salt and pepper to taste.\nStep 6: Serve on a plate and garnish with a slice of calamansi and chili.\nStep 7: If you wish to serve on a sizzling plate, preheat the plate and add a bit of butter.\nStep 8: Place the sisig on the hot plate and garnish with a slice of calamansi and chili.', '/static/assets/img/Recipes/recipe2.jpg', 'Kay', 'https://cookpad.com/uk/recipes/16807607-kapampangan-style-sisig', '5 people', '1 hr', 'A sizzling Kapampangan dish made from pork parts, usually served with calamansi and chili.', 'Meat'),
(3, 'Tocino Kapampangan Style', 'Step 1: In a large mixing bowl, add all the ingredients for the tocino marinade except for the pork slices.\nStep 2: Mix the ingredients together until well combined.\nStep 3: Add the pork slices into the marinade and mix by hand for up to an hour, or more if you have the patience to do so. (Don’t forget to use gloves to avoid stained hands!)\nStep 4: Once done with the mixing, transfer the pork to a container with a cover and let it sit overnight on the countertop.\nStep 5: Mix pork around for a couple of times more before placing it in the fridge to cure for 24 hours or up to 3 days.\nStep 6: It can be frozen afterward and stored for longer (up to 3 months).\nStep 7: Add about 2 cups of water (or just enough to cover the meat) and 1/4 cup of cooking oil into a large frying pan together with the pork tocino slices.\nStep 8: Boil over high heat.\nStep 9: When the water evaporates, the cooking oil will be left, instantly frying the meat.\nStep 10: Turn the meat over after a few minutes of frying to cook evenly on all sides.\nStep 11: Serve hot with garlicky fried rice or steamed rice and fried egg.\nStep 12: Enjoy it with the fried egg browned and crispy on the edges with a golden liquid yolk.\nStep 13: It tastes best when dipped in spicy vinegar!', '/static/assets/img/Recipes/recipe3.jpg', 'Bebs', 'https://www.foxyfolksy.com/tocino-recipe-sweet-cured-pork/', '6 people', '1 hr', 'A sweet cured pork dish, popular as a breakfast staple in the Philippines.', 'Others'),
(4, 'Pork Menudo Kapampangan Style', 'Step 1: Mix kalamansi or lemon juice with salt and pepper.\nStep 2: Marinate meat for a minimum of 30 minutes; the longer, the better. Ensure to keep in the chiller while marinating.\nStep 3: Heat oil in a pot, on low heat lightly fry diced potatoes and carrots. Take out from the pan and set aside.\nStep 4: In the same pot with oil, sauté crushed garlic, onions, annatto powder, bay leaves, and oregano.\nStep 5: Add the marinated meat, leaving the sauce on the side.\nStep 6: Simmer until no pink remains in the meat.\nStep 7: Add pork liver and sauté for about 10 minutes.\nStep 8: Add tomato paste and sauté it properly into the meat, onions, and garlic.\nStep 9: Add fish sauce, water, and let it simmer until the meat is tender.\nStep 10: Once the meat is tender, add the lightly browned potatoes, carrots, hot dogs, and green peas.\nStep 11: Taste and add salt and pepper according to your desired taste.\nStep 12: Let it simmer for 3-5 minutes.\nStep 13: Add the capsicum and raisins and let it simmer for another 3-5 minutes.\nStep 14: Serve warm with rice.', '/static/assets/img/Recipes/recipe4.jpg', 'Paulette Marie', 'https://cookpad.com/us/recipes/22569986-kapampangan-pork-menudo', '3-4 people', '1 hr 30 mins', 'A tomato-based pork stew with liver, potatoes, and vegetables.', 'Meat'),
(5, 'Beef Caldereta Kapampangan Style', 'Step 1: Boil and simmer beef brisket, onions, laurel, basil, and pepper in at least 1/2 liter water for 1 hour and 45 minutes or until tender. Remove the scums that float on top.\nStep 2: Turn off heat and take off the laurel leaf.\nStep 3: In another pan, sauté garlic in very little oil until brownish. Drain from oil once garlic is brownish and set it aside.\nStep 4: After 1 hour and 30 minutes of cooking the beef brisket, add carrots and potatoes. Leave at least 2 cups of beef broth in your pot and discard excess broth. (If you want a thick sauce for your caldereta, don’t leave too much broth.)\nStep 5: Add in tomato sauce, chili peppers, carrots, and potatoes. Simmer for 5 minutes while stirring occasionally.\nStep 6: Add in garlic, liver spread, and Nestle All Purpose cream, stirring constantly.\nStep 7: Adjust taste by adding soy sauce, sugar, fish sauce, and a pinch of salt.\nStep 8: Finally, add in bell pepper and 1 cup grated cheese. Cover pot and simmer for 1 or 2 minutes more.\nStep 9: Turn off heat. Ready to serve. Enjoy!', '/static/assets/img/Recipes/recipe5.jpg', 'Jainey', 'https://www.mamasguiderecipes.com/2018/11/03/special-beef-caldereta/#google_vignette', '6 people', '3 hrs ', 'A rich, spicy beef stew with liver spread and vegetables.', 'Meat'),
(6, 'Bringhe', 'Step 1: In a wide, thick-bottomed skillet over medium heat, heat oil. Add chorizo de bilbao and cook for about 1 to 2 minutes or until lightly browned. Remove from heat and set aside.\nStep 2: Add chicken and cook, stirring occasionally, for about 4 to 5 minutes or until color changes and lightly browned. Remove from pan and set aside.\nStep 3: In the pan, heat another tablespoon of oil. Add onions and garlic and cook until softened.\nStep 4: Add rice and cook, stirring regularly, for about 2 to 3 minutes or until lightly toasted.\nStep 5: Add fish sauce and continue to cook for 1 minute.\nStep 6: Add the coconut milk, broth, chicken, chorizo de bilbao, julienned carrots, bell peppers, green peas, and raisins.\nStep 7: Add turmeric powder and stir to combine.\nStep 8: Season with salt and pepper to taste. Bring to a boil for about 3 to 5 minutes, stirring occasionally.\nStep 9: Cover the rice mixture with banana leaves, cover the pan with lid, and continue to cook for about 15 to 20 minutes or until rice is fully cooked and liquid is absorbed.\nStep 10: If you like to toast the bottom, transfer the rice to a wide pan lined with banana leaves, cover with banana leaves, and cook on medium heat until it forms \"socarrat\" (crust). Flip the rice so the toasted bottom goes to the top and continue to cook to again form a crust.\nStep 11: To serve, garnish with red and green bell peppers, hardboiled eggs, and carrot florets.', '/static/assets/img/Recipes/recipe6.jpg', 'Lalaine Manalo', 'https://www.kawalingpinoy.com/bringhe/', '6 people', '1 hr 5 mins', 'Kapampangan-style paella made with glutinous rice, coconut milk, and turmeric.', 'Vegetable'),
(7, 'Morcon', 'Step 1: Marinate the beef in soy sauce and lemon juice for at least 1 hour.\nStep 2: Place the beef in a flat surface and arrange the hotdogs, pickle, carrot, cheese, and egg on one side.\nStep 3: Roll the beef enclosing the fillings and tie with a cooking string to ensure that the meat will not open-up.\nStep 4: Place cooking oil in a pan and apply heat.\nStep 5: Dredge the rolled beef in flour and fry until the color of the outer part turns medium brown.\nStep 6: Transfer the fried rolled beef in a casserole and pour-in the beef broth then bring to a boil.\nStep 7: Pour-in half of the soy sauce-lemon juice marinade, salt, and simmer until the beef is tender (about 2 hours using ordinary casserole or 30 minutes if a pressure cooker is used).\nStep 8: Optional: Fry the simmered meat for at least 2 minutes.\nStep 9: Remove the strings and slice into serving pieces.\nStep 10: Place in a serving dish and add the sauce.\nStep 11: Serve hot. Share and enjoy!', '/static/assets/img/Recipes/recipe7.jpg', 'Vanjo Merano', 'https://panlasangpinoy.com/beef-holiday-christmas-new-year-food-menu-morcon-recipe/', '4 people', '2 hrs', 'A beef roulade stuffed with eggs, sausages, and pickles.', 'Others'),
(8, 'Pindang Damulag (Carabeef Tocino)', 'Step 1: You should clean and dry all of your bowls and utensils. You might want to wear gloves.\nStep 2: Combine the curing powder, glutinous rice flour, pepper, salt, sugar, and garlic in a bowl.\nStep 3: Add the carabao meat and massage all the ingredients to the meat for 5 minutes, or until everything is well combined.\nStep 4: For three days, leave the plastic at room temperature. The interior will begin to bubble, as you can see. You should smell Vinegar and not decaying foul odor. By the third day, a lot of air will start to build up inside the plastic bag.\nStep 5: Note: The fermented carabeef meat should not turn green and the bag of meat should smell fermented and not rotten.\nHow to Cook: Step 1: In a pan, boil a little bit of water, and add the carabeef.\nStep 2: Just add about ¼ cup water or depending on the amount of meat. Avoid putting in too much water so it doesn’t lose its flavor.\nStep 3: Bring it to a boil and let it cook until all the water gets dry or evaporates for about 5 minutes.\nStep 4: Once the pan is dry, add some oil and continue to fry the meat until it caramelized or cooked through.\nStep 5: Serve it with fried rice, egg, sliced cucumber, tomatoes, and spiced vinegar dippings. Serve and enjoy!', '/static/assets/img/Recipes/recipe8.jpg', 'Jainey', 'https://www.mamasguiderecipes.com/2023/08/19/pindang-damulag-recipe-carabeef-tocino/', '4-6 people', '30 mins', 'A sweet cured pork dish, popular as a breakfast staple in the Philippines.', 'Meat'),
(9, 'Pork Bulanglang', 'Step 1: In a pot over medium heat, combine pork and water. Bring to a boil, skimming scum that floats on top.\nStep 2: When the broth has cleared, add onions and fish sauce.\nStep 3: Lower heat, cover, and continue to cook for about 1 to 1 ½ hours or until pork is tender. Add more water in ½ cup increments, if needed, to maintain about 6 cups.\nStep 4: Meanwhile, cut into guavas into halves and using a small spoon, scoop out the seeds.\nStep 5: In a bowl, combine guava seeds and the remaining 1 cup water. Using the back of a spoon, mash to extract pulp and strain in a fine-mesh sieve. Reserve the guava juice and discard the seeds.\nStep 6: Trim about 2 inches from the kangkongs stalks and discard. Cut kangkong into 3-inch lengths, separating the sturdier stalks from the leaves. Wash thoroughly and drain well. Set aside.\nStep 7: Add gabi, sliced guava, and the guava juice to the pot and continue to cook for about 5 minutes or until tender.\nStep 8: Season with salt to taste.\nStep 9: Add kangkong beginning with the sturdier stalks and then the leaves. Continue to cook for about 1 to 2 minutes. Serve hot.', '/static/assets/img/Recipes/recipe9.jpg', 'Lalaine Manalo', 'https://www.kawalingpinoy.com/pork-bulanglang/', '6 people', '1 hr 35 mins', 'A vegetable-based soup with fermented shrimp paste (bagoong).', 'Meat'),
(10, 'Taba ng Talangka', 'Step 1: In a small glass bowl, mix the fat/meat of the talangka with the calamansi juice and Mirin.\nStep 2: Set aside.\nStep 3: In a non-reactive cooking saucepan (use a Teflon coated or ceramic pan or glass cooking pan), warm pan over low flame for 1 minute and pour in oil.\nStep 4: Warm for 1 minute and begin to sauté the garlic till the garlic is a light golden tan.\nStep 5: Throughout the whole cooking process, keep the fire to low.\nStep 6: When the garlic is a light golden tan, pour in the crab/meat mixture.\nStep 7: Continuously stir the mixture slowly; you don’t want it to be pasty; you want some texture.\nStep 8: Season with pepper and continue to simmer till the cooking oil starts to color into a bright red orange.\nStep 9: Taste the mixture and adjust. You can add more calamansi juice, Mirin, or black pepper and salt if needed.\nStep 10: This whole procedure takes about 20 to 30 minutes.\nStep 11: When done, cool the mixture and place in a sterile container and refrigerate or you can freeze.\nStep 12: Eat with steaming hot rice or with crackers or use as a sauce.', '/static/assets/img/Recipes/recipe10.jpg', 'Lalaine Manalo', 'https://www.masarap.ph/the-art-of-making-tabang-talangka/', '4-6 people', '20-30 mins', 'Crab fat delicacy used as a topping for rice or pasta.', 'Others'),
(11, 'Stuffed Frog (Pampanga’s Betute Tugac)', 'Step 1: Season frog with salt and pepper and set aside.\nStep 2: Sauté the ground pork with garlic, onion and tomato.\nStep 3: When cooked, add the vinegar.\nStep 4: Let simmer and also let the raw taste of vinegar evaporate.\nStep 5: After 3 minutes, season with salt and pepper.\nStep 6: When done, put on platter.\nStep 7: Stuff frog with above cooked ingredients then powder frog with flour.\nStep 8: Deep fry.', '/static/assets/img/Recipes/recipe11.jpg', 'Squad Leader', 'https://foodrecipenotebook.blogspot.com/2015/06/stuffed-frog-pampangas-betute-tugac.html', '3-4 people', '35-45 mins', 'Stuffed frog dish, a local Kapampangan specialty.', 'Others'),
(12, 'San Nicolas Cookies', 'Step 1: Combine all the ingredients in a bowl: cornstarch, baking powder, salt, sugar, egg yolks, coconut milk, softened butter, lemon zest and oil. Blend well with a wooden spoon.\nStep 2: Slowly add the cake flour and the rice flour, knead it into the mixture till it resembles a thick dough and has a smooth surface.\nStep 3: Mixing by hand should take about 10 minutes till it is smooth and all ingredients are incorporated.\nStep 4: Place the dough into an airtight container and freeze for 2 to 4 hours or overnight.\nStep 5: When ready to bake, take the dough out of the freezer and thaw on the counter for 8 to 10 minutes. Keep the dough very cold so it is easy to roll out and handle on the heirloom cookie molds.\nStep 6: Grease with baking spray or shortening the surface of the San Nicolas mold which has the design. Make sure to grease the inner crevices and corners so that the dough can be removed easily after shaping.\nStep 7: Place a chunk of the dough, about 4 tablespoons over the San Nicolas mold, on the hand-carved portion. Flatten with your hand to spread it around evenly. Place a piece of parchment or wax paper over the dough, which is over the wooden mold. Using a rolling pin, roll and flatten the dough so it gets embedded in the design.\nStep 8: Place a round or oval cookie cutter over the San Nicolas mold, to cut the dough to the appropriate shape needed. Trim the edges of the cookie if needed, whether round or oval.\nStep 9: Quickly transfer the molded dough onto a baking sheet that has parchment paper or a silicone baking sheet.\nStep 10: Bake Pan de San Nicolas at a preheated oven of 325°F for 10 to 12 minutes or until the top is brown.\nStep 11: When done, cool the cookies on a cookie rack. They will be crisp on the outside, but will have a slightly soft shortbread texture inside. It will take at least 30-40 minutes for the cookies to cool on the rack.\nStep 12: When Pan de San Nicolas cookies are cooled, wrap in white cellophane wrappers to show off the intricate designs. Store in an airtight glass or plastic jar. Enjoy!', '/static/assets/img/Recipes/recipe12.jpg', 'Jainey', 'https://www.mamasguiderecipes.com/2017/04/28/san-nicolas-cookies-pampangas-delicacy/', '20–25 cookies', '2–4 hours', 'Traditional Kapampangan cookies made with arrowroot flour.', 'Others'),
(13, 'Pancit Luglug', 'Step 1: Cook Pancit Luglug noodles as per package instructions. You may also soak the noodles a few minutes before boiling to fasten the process.\nStep 2: In a pot or large skillet, heat oil over medium heat. Add the prawn and cook for a minute or until the color turns opaque and pink. Remove from oil and cut each piece into half, lengthwise, and set aside.\nStep 3: In the same oil, sauté the garlic and onion until limp and aromatic. Add the ground pork and season with fish sauce and pepper. Cook until no longer pink while stirring and pressing to break up the lumps.\nStep 4: While pork is cooking, take a bowl and dissolve the flour and achuete powder in 1 cup of water. Set aside.\nStep 5: Once the pork is cooked, add 4 cups of water and the shrimp cube. Bring water to a soft boil.\nStep 6: Gradually pour in the flour-achuete mixture into the pot while stirring continuously to avoid lumps. Simmer until the sauce becomes thick while stirring from time to time to prevent the sauce from burning.\nStep 7: Divide the noodles accordingly into the serving plates. Pour a generous amount of sauce on top of the noodles. Sprinkle with crushed chicharon and shredded tinapa. Add 2 quarters of hard-boiled egg and 3 slices of prawns. Finish off with some toasted garlic and chopped green onions. Serve with calamansi.', '/static/assets/img/Recipes/recipe13.jpg', 'Bebs', 'https://www.foxyfolksy.com/pancit-luglug/', '8 people', '30 mins', 'Thick rice noodles with a rich shrimp sauce, similar to palabok.', 'Others'),
(14, 'Adobong Kamaru', 'Step 1: To prepare Adobong Kamaru, first, wash the Kamaru very well, make sure to expel all the dirt, better yet soak it in water or vinegar if you have doubt. Then, sauté garlic and onion.\nStep 2: Add the sliced tomatoes, siling labuyo, and the Kamaru. Mix it well and simmer for 5 minutes.\nStep 3: Add the ¼ cup of vinegar and wait for 2 minutes. Don’t mix it, just let it boil.\nStep 4: Add salt and pepper to taste and serve.', '/static/assets/img/Recipes/recipe14.jpg', 'Ryka', 'https://filipinofoodrecipesreview.blogspot.com/2012/05/adobong-kamaru-filipino-exotic-food.html', '2-3 people', '20–25 mins', 'Crispy or sautéed mole crickets, a unique Kapampangan delicacy.', 'Others'),
(15, 'Begucan Babi', 'Step 1: Let’s begin by making annatto oil. First, heat together 1 tbsp annatto seeds and 2 tbsp vegetable oil in medium heat. Allow this to sizzle and remove the seeds when it turns dark in color. Remove the seeds and keep the oil.\nStep 2: In the same pan, drop the garlic, onions, tomatoes, and bagoong in the annatto oil.\nStep 3: Pour in the vinegar. Simmer for a minute to cook before adding Knorr Pork Broth Cube, pork liempo, pepper, and green chili. Bring this to a boil and then simmer until the meat is tender.\nStep 4: Serve and enjoy! You will surely eat a lot when your mom serves you this Kapampangan dish. Manyaman!', '/static/assets/img/Recipes/recipe15.jpg', 'Knorr Recipes', 'https://www.knorr.com/ph/r/begucan-babi-recipe.html/110808', '3 people', '45 mins', 'Kapampangan pork dish cooked in fermented shrimp paste.', 'Others'),
(16, 'Pork Estofado', 'Step 1: Heat a frying pan and pour 3/4 cups of cooking oil. When the oil is hot enough, fry the sliced plantains until the color of each side turns medium to dark brown. Set aside.\nStep 2: Pour 1/4 cup of cooking oil in a separate cooking pot then apply heat. When the oil is hot enough, put-in the garlic and sauté until the color turns light brown.\nStep 3: Add the cubed pork and cook for 7 to 10 minutes.\nStep 4: Put-in the soy sauce, water, whole peppercorns, and dried bay leaves then bring to a boil. Simmer until pork is tender.\nStep 5: Add vinegar and wait for the liquid to re-boil. Simmer for 5 minutes.\nStep 6: Add brown sugar and carrots. Stir then simmer for 10 minutes more.\nStep 7: Turn off the heat and transfer the contents of the cooking pot to a serving plate.\nStep 8: Garnish with fried bananas then serve. Share and enjoy!', '/static/assets/img/Recipes/recipe16.jpg', 'Vanjo Merano', 'https://panlasangpinoy.com/pork-estofado-recipe/', '6 people', '1 hr 10 mins', 'A sweet pork dish braised with bananas and soy sauce.', 'Meat'),
(17, 'Pork Embutido', 'Step 1: Prepare the embutido meatloaf by combining the following ingredients in a large mixing bowl: ground pork, onion, red bell pepper, carrot, sweet relish, raisins, cheese, eggs, salt, and ground black pepper. Mix well until all ingredients are blended.\nStep 2: Add the bread crumbs. Continue to mix until well blended.\nStep 3: Scoop a cup of embutido mixture and place over a sheet of pre-cut aluminum foil (12 x 10 inches). Mold the mixture to form a cylindrical shape. Roll the foil and secure both edges. Set aside. Do this until all the embutido meatloaf mixture is consumed.\nStep 4: Arrange the wrapped embutido in a steamer. Pour water on the steamer and let boil. Steam (in medium heat) for 60 minutes.\nStep 5: Remove the steamed pork embutido from the steamer. Let it cool down. Chill in the refrigerator for 2 hours. Slice and arrange in a serving plate. You can also fry it.\nStep 6: Serve. Share and enjoy!', '/static/assets/img/Recipes/recipe17.jpg', 'Vanjo Merano', 'https://panlasangpinoy.com/pork-embutido-steamed-filipino-meatloaf/#wprm-recipe-container-48260', '10 people', '1 hr 15 mins', 'A Filipino-style meatloaf with eggs and sausages inside.', 'Meat'),
(18, 'Pork Asado Kapampangan Style', 'Step 1: In a large bowl, combine calamansi juice, soy sauce, onions, garlic, and peppercorns. Whisk until distributed. (Note: Do not marinate the pork for too long as the acids in the marinade will denature the protein fibers and turn the meat mushy. At least 30 minutes up to overnight should do the trick.)\nStep 2: Add pork and massage marinade on the meat. Marinate in the refrigerator for about 2 to 4 hours. Drain meat, reserving liquid, onions, and garlic.\nStep 3: In a wide, thick-bottomed pan over medium heat, heat oil. Add potatoes and cook until tender and lightly browned. Remove from pan and drain on paper towels. (Note: Pan-fry the potatoes until lightly browned to keep them from falling apart when finished off in the sauce.)\nStep 4: Add pork and sear on all sides until lightly browned. Remove from the pan and drain on paper towels. (Note: Sear the meat properly to add color and enhance flavor. Pat the meat dry and cook on high heat so it will brown and not steam.)\nStep 5: Remove excess oil except for about 2 tablespoons. Add the reserved onions and garlic (from the marinade) and cook until softened.\nStep 6: Add the reserved marinade, scraping sides and bottom of the pan to deglaze.\nStep 7: Add tomato sauce, water, and bay leaf. Stir to combine.\nStep 8: Add pork. Bring to a boil, skimming any scum that floats on top.\nStep 9: Lower heat, cover, and simmer until meat is fork-tender. With a slotted spoon, remove and set aside.\nStep 10: Add liver spread to the sauce and stir to distribute.\nStep 11: Continue to cook until thickened. Season with salt and pepper to taste.\nStep 12: Slice pork into serving slices and arrange on a platter. Garnish with fried potatoes and pour sauce on top. Serve hot. (Note: For a richer flavor, you can shredded quick-melt cheese to the sauce.)', '/static/assets/img/Recipes/recipe18.jpg', 'Bebs', 'https://www.foxyfolksy.com/pork-asado-kapampangan/#recipe', '5 people', '1 hr 5 mins', 'Kapampangan-style braised pork with a sweet-savory sauce.', 'Meat'),
(19, 'Pork Lengua with White Creamy Sauce', 'Step 1: Place the pork tongue in a pressure cooker. Sprinkle 1 tablespoon of salt and fill with enough water just to cover the meat. Cook in pressure cooker for 25-30 minutes.\nStep 2: Remove tongue from liquid and transfer to a work surface and cool slightly. Reserve a cup of the broth. Peel outer layer of skin from pork tongue. Cut the meat in thin slices about a quarter inch thick.\nStep 3: Melt butter on a large skillet over medium heat. Saute garlic and onion until aromatic and tender.\nStep 4: Add the pork tongue slices and season with soy sauce. Let it cook for 2-3 minutes turning the meat slices once or twice.\nStep 5: Pour in evaporated milk and broth and add the corn kernels. Season with salt and pepper. Let it simmer for 5-7 minutes or until liquids starts to get thick.\nStep 6: Add all-purpose cream and simmer for another minute. Add salt if needed.\nStep 7: Transfer to a serving plate and serve with steamed rice or mashed potatoes.\n(Note: If you do not have a pressure cooker, just boil the tongue in a pot over stove-top over high heat. Once it starts to boil, set heat to low and cover with lid. Let it simmer for 1-2 hours or until the pork tongue becomes fork-tender.)', '/static/assets/img/Recipes/recipe19.jpg', 'Bebs', 'https://www.foxyfolksy.com/pork-lengua-recipe/#recipe', '4 people', '45 mins', 'Ox tongue cooked in a creamy white sauce.', 'Meat'),
(20, 'Kapampangan Lechon Paksiw', 'Step 1: In a pot or wok, heat oil. Sauté onion and garlic until limp and aromatic.\nStep 2: Add leftover lechon and cook until lightly browned. Add water and allow to simmer for about 2 minutes.\nStep 3: Add white vinegar, and bring to a boil, uncovered and without stirring, for 2 to 3 minutes. Add peppercorns, salt, and bay leaves. Stir and allow to simmer for another minute or two.\nStep 4: Pour in lechon sauce, and cook for a minute. Add sugar, and cook until the sauce slightly thickens.\nStep 5: Best to serve a day after cooking, once all the flavors and aromatics have been absorbed.', '/static/assets/img/Recipes/recipe20.jpg', 'Dolly Dy-Zulueta', 'https://www.philstar.com/lifestyle/food-and-leisure/2024/01/17/2326306/recipe-kapampangan-lechon-paksiw', '4-6 people', '30-40 mins', 'Roasted pig leftovers stewed in vinegar and liver sauce.', 'Meat'),
(21, 'Sweet Longganisa (Pampanga Style)', 'Step 1: In a large bowl, mix all ingredients except for the hog casing and canola oil. Combine very well. Transfer to container with a tight cover and refrigerate for hours or overnight. Cook a teaspoon of the meat to do taste test, adjust the seasoning as needed.\nStep 2: If hog casing is not available: You can make skinless longganisa. Just shape the marinated ground pork into 3-inch sausages and cook over achuete oil. Fry in a lightly oiled frying pan until cooked through and golden brown.\nStep 3: If Hog casing is available: Clean and wash hog casings thoroughly with warm running water first. Once the hog casing is clean, stuff them with the sausage meat.\nStep 4: To Cook Longganisa: Transfer the sausage links in a pan and put enough water (about halfway up the sides of the sausage). Simmer over medium-to low heat, stirring occasionally and until all water evaporates and oil comes out from the longganisa. Add a little oil if needed and fry until longganisa turns golden brown.', '/static/assets/img/Recipes/recipe21.jpg', 'Jainey', 'https://www.mamasguiderecipes.com/2017/09/14/sweet-longganisa-pampanga-style/', '8-10 people', '25-35 mins', 'Sweet and garlicky pork sausage, famous in Pampanga.', 'Meat'),
(22, 'Barquillos (Wafer Rolls) Recipe 1', 'Step 1: Preheat an oven to 375°F (190°C).\nStep 2: Lightly grease 2 baking sheets. Beat the butter, sugar, and vanilla with an electric mixer in a large bowl until smooth. Add the egg whites one at a time, allowing each to blend into the butter mixture before adding the next.\nStep 3: Mix in the flour until just incorporated. Drop teaspoonfuls of the dough onto ungreased baking sheets.\nStep 4: Spread thinly with a spatula or the back of the spoon into a 3-inch circle.\nStep 5: Bake in the preheated oven until browned along the edges, about 3-5 minutes.\nStep 6: Remove the baked wafers from the baking sheet one at a time using a stick/skewer or spatula roll it. You may also roll each wafer around the handle of a wooden spoon until the edges overlap.\nStep 7: Cool seam-side down on a wire rack until completely crisp. As you practice making barquillos, you will eventually learn to make thinner rolls. Happy cooking and enjoy!', '/static/assets/img/Recipes/recipe22.jpg', 'Jainey', 'https://www.mamasguiderecipes.com/2017/04/28/barquillos-wafer-rolls-mamas-guide/', '18 people', '20-25 mins', 'Thin, crispy wafer rolls, often filled with sweet treats.', 'Others'),
(23, 'Barquillos (Wafer Rolls) Recipe 2', 'Step 1: Beat the egg yolks. Pour in milk and stir lightly. Add the flour. Mix well.\nStep 2: Add sugar (according to taste or desired amount) and powdered rind or vanilla.\nStep 3: Grease the barquillera or hot iron and prepare it to moderate heat.\nStep 4: Get about a tablespoon of batter and place it on the hot iron. Press and heat on both sides until the color turns to light brown.\nStep 5: While still hot, shape the soft batter using the handle of a wooden spoon or chopstick, then roll it to form a tube. Make sure to grease the handle (or the pin) to prevent the barquillos from sticking. Happy cooking and enjoy!', '/static/assets/img/Recipes/recipe22.jpg', 'Jainey', 'https://www.mamasguiderecipes.com/2017/04/28/barquillos-wafer-rolls-mamas-guide/', '18 people', '20-25 mins', 'Thin, crispy wafer rolls, often filled with sweet treats.', 'Others'),
(24, 'Tibok-Tibok', 'Step 1: In a pan over medium heat, add coconut cream and bring to a boil. Continue to cook, stirring occasionally, until liquid starts to thicken.\nStep 2: Lower heat and simmer. As oil starts to separate and solids begin to form, regularly stir and scrape sides and bottom of the pan to prevent from burning. Continue to cook and stir until curds turn golden brown.\nStep 3: Using a fine mesh sieve or colander, drain latik. Reserve oil.\nStep 4: Generously brush bottom and sides of 7 x 5-inch pan with coconut oil and set aside.\nStep 5: In a heavy-bottomed pot, combine milk, rice flour, and sugar. Add salt if using cow\'s milk. Whisk together until smooth and well-blended.\nStep 6: Over medium-low heat, bring to a simmer, whisking regularly. Continue to cook, whisking regularly, for about 10 to 15 minutes or until mixture thickens to a smooth thick paste.\nStep 7: Gently transfer milk mixture to prepared pan. Smooth and evenly distribute using a spatula.\nStep 8: Allow to slightly cool and set. Generously brush with coconut oil and garnish with latik. Cut into serving slices.', '/static/assets/img/Recipes/recipe24.jpg', 'Lalaine Manalo', 'https://www.kawalingpinoy.com/tibok-tibok/', '8 people', '2 hrs 40 mins', 'Kapampangan carabao milk pudding, similar to maja blanca.', 'Others');

-- --------------------------------------------------------

--
-- Table structure for table `history`
--

CREATE TABLE `history` (
  `id` int(11) NOT NULL,
  `user_ID` int(11) NOT NULL,
  `dish_name` varchar(255) NOT NULL,
  `date` date NOT NULL,
  `ingredients` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `history`
--

INSERT INTO `history` (`id`, `user_ID`, `dish_name`, `date`, `ingredients`) VALUES
(44, 1, 'Sisig Kapampangan Style With (Pork Belly) ', '2025-02-16', 'pork belly, red chili, black pepper, salt'),
(45, 1, 'Pork Menudo Kapampangan Style ', '2025-02-16', 'pork belly, black pepper, salt'),
(46, 1, 'Tocino Kapampangan Style ', '2025-02-16', 'pork belly, black pepper, salt');

-- --------------------------------------------------------

--
-- Table structure for table `ingredients`
--

CREATE TABLE `ingredients` (
  `id` int(11) NOT NULL,
  `ingredient_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ingredients`
--

INSERT INTO `ingredients` (`id`, `ingredient_name`) VALUES
(1, 'all purpose cream'),
(2, 'annatto powder'),
(3, 'bay leaf'),
(4, 'beef brisket'),
(5, 'beef eye round'),
(6, 'black pepper'),
(7, 'brown sugar'),
(8, 'butter'),
(9, 'calamansi'),
(10, 'calamansi juice'),
(11, 'carrot'),
(12, 'chicken liver'),
(13, 'cow milk'),
(14, 'crab'),
(15, 'dill'),
(16, 'egg'),
(17, 'fish sauce'),
(18, 'frog'),
(19, 'garlic'),
(20, 'grated cheese'),
(21, 'green bell pepper'),
(22, 'green chili'),
(23, 'green peas'),
(24, 'guava'),
(25, 'hard boiled egg'),
(26, 'hotdogs'),
(27, 'lemon'),
(28, 'lemon juice'),
(29, 'liver spread'),
(30, 'oregano'),
(31, 'pineapple juice'),
(32, 'plantain'),
(33, 'pork belly'),
(34, 'pork butt'),
(35, 'pork ear'),
(36, 'pork face'),
(37, 'pork liver'),
(38, 'pork rind'),
(39, 'pork shoulder'),
(40, 'pork skin'),
(41, 'potato'),
(42, 'prawn'),
(43, 'raisin'),
(44, 'red bell pepper'),
(45, 'red chili'),
(46, 'red onion'),
(47, 'salt'),
(48, 'sirloin steak'),
(49, 'skinless chicken'),
(50, 'soy sauce'),
(51, 'sweet pickle relish'),
(52, 'taro'),
(53, 'tomato'),
(54, 'tomato paste'),
(55, 'tomato sauce'),
(56, 'vanilla extract'),
(57, 'vegetable oil'),
(58, 'vinegar'),
(59, 'water spinach'),
(60, 'white onion'),
(61, 'chili flakes'),
(62, 'natural red food color'),
(63, 'chili pepper'),
(64, 'chicken broth'),
(65, 'chorizo de bilbao'),
(66, 'coconut milk'),
(67, 'glutinous rice'),
(68, 'turmeric powder'),
(69, 'beef cubes'),
(70, 'flour'),
(71, 'pickled dill'),
(72, 'ground pork'),
(73, 'onion leeks'),
(74, 'baking powder'),
(75, 'cake flour'),
(76, 'cornstarch'),
(77, 'rice flour'),
(78, 'green onions'),
(79, 'shrimp cube'),
(80, 'smoked fish');

-- --------------------------------------------------------

--
-- Table structure for table `ingredient_list`
--

CREATE TABLE `ingredient_list` (
  `id` int(11) NOT NULL,
  `ingredient_name` varchar(255) NOT NULL,
  `category` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ingredient_list`
--

INSERT INTO `ingredient_list` (`id`, `ingredient_name`, `category`) VALUES
(1, 'carrot', 'Vegetables & Greens'),
(2, 'green bell pepper', 'Vegetables & Greens'),
(3, 'green chili', 'Vegetables & Greens'),
(4, 'green onions', 'Vegetables & Greens'),
(5, 'guava', 'Vegetables & Greens'),
(6, 'onion', 'Vegetables & Greens'),
(7, 'onion leeks', 'Vegetables & Greens'),
(8, 'potato', 'Vegetables & Greens'),
(9, 'red bell pepper', 'Vegetables & Greens'),
(10, 'red chili', 'Vegetables & Greens'),
(11, 'red onion', 'Vegetables & Greens'),
(12, 'taro', 'Vegetables & Greens'),
(13, 'tomato', 'Vegetables & Greens'),
(14, 'water spinach', 'Vegetables & Greens'),
(15, 'white onion', 'Vegetables & Greens'),
(16, 'yellow onion', 'Vegetables & Greens'),
(17, 'banana', 'Fruits'),
(18, 'calamansi', 'Fruits'),
(19, 'lemon', 'Fruits'),
(20, 'cheese', 'Cheeses'),
(21, 'grated cheese', 'Cheeses'),
(22, 'all purpose cream', 'Dairy & Eggs'),
(23, 'butter', 'Dairy & Eggs'),
(24, 'cow milk', 'Dairy & Eggs'),
(25, 'egg', 'Dairy & Eggs'),
(26, 'evaporated milk', 'Dairy & Eggs'),
(27, 'hard-boiled eggs', 'Dairy & Eggs'),
(28, 'margarine', 'Dairy & Eggs'),
(29, 'beef brisket', 'Meats'),
(30, 'beef cubes', 'Meats'),
(31, 'beef eye round', 'Meats'),
(32, 'flank steak', 'Meats'),
(33, 'ground pork', 'Meats'),
(34, 'pork belly', 'Meats'),
(35, 'pork butt', 'Meats'),
(36, 'pork ear', 'Meats'),
(37, 'pork face', 'Meats'),
(38, 'pork liempo', 'Meats'),
(39, 'pork liver', 'Meats'),
(40, 'pork rind', 'Meats'),
(41, 'pork shoulder', 'Meats'),
(42, 'pork skin', 'Meats'),
(43, 'pork tongue', 'Meats'),
(44, 'chicken broth', 'Poultry'),
(45, 'chicken liver', 'Poultry'),
(46, 'chicken thigh meat', 'Poultry'),
(47, 'smoked fish', 'Fish'),
(48, 'crab', 'Seafood & Seaweed'),
(49, 'prawn', 'Seafood & Seaweed'),
(50, 'shrimp cube', 'Seafood & Seaweed'),
(51, 'bay leaf', 'Herbs & Spices'),
(52, 'black pepper', 'Herbs & Spices'),
(53, 'chili flakes', 'Herbs & Spices'),
(54, 'chili pepper', 'Herbs & Spices'),
(55, 'garlic', 'Herbs & Spices'),
(56, 'ground pepper', 'Herbs & Spices'),
(57, 'oregano', 'Herbs & Spices'),
(58, 'turmeric powder', 'Herbs & Spices'),
(59, 'brown sugar', 'Sugar & Sweeteners'),
(60, 'sugar', 'Sugar & Sweeteners'),
(61, 'white sugar', 'Sugar & Sweeteners'),
(62, 'achuete oil', 'Seasonings & Spice Blends'),
(63, 'annatto powder', 'Seasonings & Spice Blends'),
(64, 'bagoong', 'Seasonings & Spice Blends'),
(65, 'fish sauce', 'Seasonings & Spice Blends'),
(66, 'knorr pork broth cubes', 'Seasonings & Spice Blends'),
(67, 'lechon sauce', 'Seasonings & Spice Blends'),
(68, 'liver spread', 'Seasonings & Spice Blends'),
(69, 'mirin', 'Seasonings & Spice Blends'),
(70, 'natural red food color', 'Seasonings & Spice Blends'),
(71, 'salt', 'Seasonings & Spice Blends'),
(72, 'shrimp cube', 'Seasonings & Spice Blends'),
(73, 'soy sauce', 'Seasonings & Spice Blends'),
(74, 'sweet pickled cucumber', 'Seasonings & Spice Blends'),
(75, 'sweet pickle relish', 'Seasonings & Spice Blends'),
(76, 'tusino curing powder', 'Seasonings & Spice Blends'),
(77, 'vinegar', 'Seasonings & Spice Blends'),
(78, 'all purpose flour', 'Baking'),
(79, 'baking powder', 'Baking'),
(80, 'bread crumbs', 'Baking'),
(81, 'cake flour', 'Baking'),
(82, 'cornstarch', 'Baking'),
(83, 'flour', 'Baking'),
(84, 'rice flour', 'Baking'),
(85, 'vanilla', 'Baking'),
(86, 'vanilla extract', 'Baking'),
(87, 'glutinous rice', 'Grains & Cereals'),
(88, 'green peas', 'Legumes'),
(89, 'pancit luglug noodles', 'Pasta'),
(90, 'butter', 'Oils & Fats'),
(91, 'margarine', 'Oils & Fats'),
(92, 'oil', 'Oils & Fats'),
(93, 'vegetable oil', 'Oils & Fats'),
(94, 'pickled dill', 'Condiments'),
(95, 'lechon sauce', 'Condiments'),
(96, 'liver spread', 'Condiments'),
(97, 'sweet pickle relish', 'Condiments'),
(98, 'corn kernel', 'Canned Food'),
(99, 'tomato paste', 'Canned Food'),
(100, 'tomato sauce', 'Canned Food'),
(101, 'liver spread', 'Sauces, Spreads & Dips'),
(102, 'tomato sauce', 'Sauces, Spreads & Dips'),
(103, 'broth', 'Soups, Stews & Stocks'),
(104, 'chicken broth', 'Soups, Stews & Stocks'),
(105, 'mirin', 'Wine, Beer & Spirits'),
(106, 'calamansi juice', 'Beverages'),
(107, 'lemon juice', 'Beverages'),
(108, 'pineapple juice', 'Beverages'),
(109, 'water', 'Beverages'),
(110, 'vanilla extract', 'Supplements & Extracts'),
(111, 'chorizo de bilbao', 'Exotic'),
(112, 'frog', 'Exotic'),
(113, 'hog casing', 'Exotic'),
(114, 'kamaru', 'Exotic');

-- --------------------------------------------------------

--
-- Table structure for table `recipe`
--

CREATE TABLE `recipe` (
  `dish_id` int(11) NOT NULL,
  `ingredient_name` varchar(100) NOT NULL,
  `measurement` varchar(100) DEFAULT NULL,
  `category` enum('main','secondary','common') DEFAULT 'common'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `recipe`
--

INSERT INTO `recipe` (`dish_id`, `ingredient_name`, `measurement`, `category`) VALUES
(1, 'black pepper', 'to taste', 'common'),
(1, 'calamansi', '3-4 pieces', 'secondary'),
(1, 'chicken liver', '3 pieces', 'main'),
(1, 'chili flakes', '¼ tablespoon', 'secondary'),
(1, 'lemon', '½', 'secondary'),
(1, 'pork belly', '0.45 kg', 'main'),
(1, 'red chili', '1-2 pieces', 'secondary'),
(1, 'red onion', '1 big', 'secondary'),
(1, 'salt', 'to taste', 'common'),
(1, 'soy sauce', '½ tablespoon', 'common'),
(2, 'black pepper', 'to taste', 'common'),
(2, 'calamansi', '10 pcs, juiced', 'common'),
(2, 'chicken liver', '0.25 kg grilled', 'secondary'),
(2, 'green chili', '1 pc, thinly sliced', 'common'),
(2, 'pork ear', '0.75 kg (includes other pork parts)', 'main'),
(2, 'pork face', '0.75 kg (includes other pork parts)', 'main'),
(2, 'pork skin', '0.75 kg (includes other pork parts)', 'main'),
(2, 'red chili', '2 pcs, thinly sliced', 'common'),
(2, 'salt', 'to taste', 'common'),
(2, 'white onion', '2 pcs, minced', 'secondary'),
(3, 'black pepper', '1/2 tbsp', 'common'),
(3, 'brown sugar', '3/4 cup', 'secondary'),
(3, 'garlic', '3 cloves, finely minced', 'common'),
(3, 'natural red food color', 'optional', 'common'),
(3, 'pineapple juice', '1/4 cup', 'secondary'),
(3, 'pork belly', '1 kg (includes pork butt), cut into 1/4 inch thin slices', 'main'),
(3, 'pork butt', '1 kg (includes pork belly), cut into 1/4 inch thin slices', 'main'),
(3, 'salt', '1 & 1/2 tbsp', 'common'),
(3, 'soy sauce', '1 tbsp', 'common'),
(3, 'vinegar', '2 tbsp', 'common'),
(4, 'annatto powder', '1 tsp', 'common'),
(4, 'bay leaf', '2 pcs', 'common'),
(4, 'black pepper', '1/2 tsp', 'common'),
(4, 'calamansi juice', '1/4 cup (alternative for lemon juice)', 'common'),
(4, 'carrot', '1 cup (diced)', 'secondary'),
(4, 'fish sauce', '2 tbsp', 'secondary'),
(4, 'green bell pepper', '1 cup (include red bell pepper)', 'secondary'),
(4, 'green peas', '1/4 cup', 'secondary'),
(4, 'hotdogs', '3 pieces (sliced and simmered)', 'secondary'),
(4, 'lemon juice', '1/4 cup (alternative for calamansi juice)', 'common'),
(4, 'oregano', '1/4 tsp', 'common'),
(4, 'pork belly', '1 lb', 'main'),
(4, 'pork liver', '1 cup (washed and drained)', 'secondary'),
(4, 'potato', '1 cup (diced)', 'secondary'),
(4, 'raisin', '1/4 cup', 'secondary'),
(4, 'red bell pepper', '1 cup', 'secondary'),
(4, 'salt', '1 tsp', 'common'),
(4, 'tomato paste', '1 tbsp', 'secondary'),
(4, 'water or stock if desired', '2 cups', 'common'),
(5, 'all purpose cream', '1/2 cup', 'secondary'),
(5, 'bay leaf', '1', 'common'),
(5, 'beef brisket', '1 kg cut into squares', 'main'),
(5, 'black pepper', 'to taste', 'common'),
(5, 'brown sugar', '2 tbsp (optional)', 'secondary'),
(5, 'carrot', '2 pcs, sliced into bite size', 'secondary'),
(5, 'chili pepper', '1-2 pcs, minced', 'common'),
(5, 'fish sauce', '1/4 tbsp, adjust to preference', 'secondary'),
(5, 'garlic', '1 head, chopped', 'common'),
(5, 'grated cheese', '1 cup', 'secondary'),
(5, 'green bell pepper', '2 pcs, cut into square', 'secondary'),
(5, 'liver spread', '1-2', 'secondary'),
(5, 'oregano', '1/4 tsp (optional)', 'common'),
(5, 'potato', '2 pcs, cut in squares', 'secondary'),
(5, 'salt', 'to taste', 'common'),
(5, 'soy sauce', '4 tbsp', 'common'),
(5, 'tomato sauce', '4 pcs, 250ml', 'secondary'),
(5, 'white onion', '2 large pcs, chopped', 'secondary'),
(6, 'black pepper', 'to taste', 'common'),
(6, 'carrot', '1 large, peeled and julienned and florets to garnish', 'secondary'),
(6, 'chicken broth', '2 cups or water', 'secondary'),
(6, 'chicken thigh meat', '1 lb, boneless, skinless, cut into 2-inch cubes', 'main'),
(6, 'chorizo de bilbao', '2 pcs (about 5 ounces), sliced into ½ inch thick', 'secondary'),
(6, 'coconut milk', '2 cups', 'secondary'),
(6, 'egg', '2, hard-boiled peeled and quartered', 'secondary'),
(6, 'fish sauce', '1 tablespoon', 'secondary'),
(6, 'garlic', '2 cloves, peeled and minced', 'common'),
(6, 'glutinous rice', '2 cups, unwashed', 'main'),
(6, 'green bell pepper', '½, seeded, cored and cut into strips to garnish', 'secondary'),
(6, 'green peas', '1 cup, frozen, thawed', 'secondary'),
(6, 'onion', '1, peeled and sliced thinly', 'secondary'),
(6, 'raisin', '¼ cup', 'secondary'),
(6, 'red bell pepper', '½, seeded, cored and cut into strips to garnish', 'secondary'),
(6, 'salt', 'to taste', 'common'),
(6, 'turmeric powder', '2 teaspoons', 'secondary'),
(6, 'vegetable oil', '2 tablespoons', 'common'),
(7, 'beef cubes', '2 pieces, dissolved in 3 cups boiling water (beef stock/broth)', 'secondary'),
(7, 'beef eye round', '2 lbs, 3/4 inch thick in one piece (alternative for flank steak)', 'main'),
(7, 'carrot', '1 piece, medium sized, cut into long strips', 'secondary'),
(7, 'cheese', '3 ounces, cut in strips (about 1/2 inch thick)', 'secondary'),
(7, 'flank steak', '2 lbs, 3/4 inch thick in one piece (alternative for beef eye of round)', 'main'),
(7, 'flour', '1/2 cup', 'common'),
(7, 'hard boiled eggs', '3 pieces, sliced', 'secondary'),
(7, 'hotdogs', '4 pieces, cut in half lengthwise', 'secondary'),
(7, 'lemon', '1 piece', 'secondary'),
(7, 'pickled dill', '2 pieces, cut lengthwise, divided into 4 equal pieces (alternative for sweet pickled cucumber)', 'secondary'),
(7, 'salt', '1/4 tsp', 'common'),
(7, 'soy sauce', '1/2 cup', 'common'),
(7, 'sweet pickled cucumber', '2 pieces, cut lengthwise, divided into 4 equal pieces (alternative for pickled dill)', 'secondary'),
(7, 'vegetable oil', '1/2 cup', 'common'),
(8, 'black pepper', '1/2 tsp', 'common'),
(8, 'brown sugar', '1/2 cup', 'secondary'),
(8, 'fish sauce', '1/4 tsp', 'secondary'),
(8, 'garlic', '3 Tbsp', 'secondary'),
(8, 'glutinous rice', '1/2 cup', 'secondary'),
(8, 'pork belly', '1 kg washed & sliced, keep cool until ready to use', 'main'),
(8, 'salt', '1 tsp', 'common'),
(8, 'Tusino curing powder', '2 tbsp', 'secondary'),
(9, 'fish sauce', '1 tablespoon', 'secondary'),
(9, 'guava', '0.45 kg (about 10 to 12 pieces)', 'secondary'),
(9, 'onion', '1, peeled and quartered', 'secondary'),
(9, 'pork belly', '0.9 kg cut into 2-inch cubes', 'main'),
(9, 'salt', 'to taste', 'common'),
(9, 'taro', '8 pieces, peeled and cut into 2-inch chunks', 'secondary'),
(9, 'water', '7 cups', 'common'),
(9, 'Water spinach', '1 bunch', 'secondary'),
(10, 'black pepper', '½ teaspoon, freshly ground', 'common'),
(10, 'calamansi juice', '1 tablespoon', 'secondary'),
(10, 'crab', '200 pieces female 20 pieces male', 'main'),
(10, 'garlic', '2 tablespoons crushed', 'common'),
(10, 'mirin', '1 tablespoon', 'secondary'),
(10, 'vegetable oil', '¼ cup', 'common'),
(11, 'black pepper', 'to taste', 'common'),
(11, 'frog', '3-5 pcs, cleaned & skinned', 'main'),
(11, 'garlic', '2 teaspoons, minced', 'common'),
(11, 'ground pork', '½ kg', 'main'),
(11, 'onion', '1, chopped', 'secondary'),
(11, 'onion leeks', 'to taste, chopped (optional)', 'secondary'),
(11, 'salt', 'to taste', 'common'),
(11, 'tomato', '2, chopped', 'secondary'),
(11, 'vinegar', '½ cup', 'common'),
(12, 'baking powder', '1 tablespoon', 'common'),
(12, 'brown sugar', '1 cup plus 2 tablespoons', 'common'),
(12, 'butter', '1/2 cup, softened at room temperature', 'secondary'),
(12, 'cake flour', '2 cups', 'secondary'),
(12, 'coconut milk', '1/2 cup (canned)', 'secondary'),
(12, 'cornstarch', '1/2 cup', 'secondary'),
(12, 'egg', '6', 'main'),
(12, 'lemon', '1 teaspoon', 'secondary'),
(12, 'rice flour', '1 and 1/2 cups (Mochiko brand, from Asian markets)', 'main'),
(12, 'salt', '1/2 teaspoon', 'common'),
(12, 'vegetable oil', '1/2 cup', 'secondary'),
(13, 'annatto powder', '1 tablespoon', 'secondary'),
(13, 'calamansi', '8 pieces, cut into halves', 'secondary'),
(13, 'fish sauce', '4 tablespoons', 'secondary'),
(13, 'flour', '1/2 cup', 'secondary'),
(13, 'garlic', '3 cloves, minced ', 'secondary'),
(13, 'green onions', '1 cup, chopped', 'secondary'),
(13, 'ground pepper', '1 teaspoon', 'common'),
(13, 'ground pork', '250 grams', 'main'),
(13, 'hard boiled eggs', '4 pieces, each cut into quarters', 'secondary'),
(13, 'oil', '3 tablespoons', 'secondary'),
(13, 'onion', '1 medium, chopped', 'secondary'),
(13, 'Pancit Luglug noodles', '500 grams', 'main'),
(13, 'pork rind', '1 cup, crushed', 'secondary'),
(13, 'prawn', '12 pieces, shelled and deveined', 'main'),
(13, 'shrimp cube', '1 piece', 'secondary'),
(13, 'smoked fish', '1 cup, shredded', 'secondary'),
(13, 'toasted garlic', '1/4 cup', 'secondary'),
(13, 'water', '5 cups', 'common'),
(14, 'black pepper', '1 teaspoon', 'common'),
(14, 'garlic', '1/4 cup, minced', 'secondary'),
(14, 'kamaru', '1/4 kg (mole crickets)', 'main'),
(14, 'onion', '1 medium size, sliced', 'secondary'),
(14, 'red chili', '2-5 pieces', 'secondary'),
(14, 'salt', '1 teaspoon', 'common'),
(14, 'tomato', '3 pieces', 'secondary'),
(14, 'vinegar', '1/4 cup', 'common'),
(15, 'annatto powder', '1 tbsp (annatto seeds, infused in oil)', 'secondary'),
(15, 'bagoong', '3/4 cup', 'secondary'),
(15, 'black pepper', '1 tsp ground', 'common'),
(15, 'garlic', '3 cloves, crushed', 'secondary'),
(15, 'green chili', '1 piece', 'secondary'),
(15, 'Knorr Pork Broth Cubes', '1 piece', 'secondary'),
(15, 'onion', '1 tbsp, chopped', 'secondary'),
(15, 'pork liempo', '1/2 kg 1 1/2 inch cubes', 'main'),
(15, 'tomato', '3 pieces, deseeded, sliced', 'secondary'),
(15, 'vinegar', '1/2 cup', 'common'),
(16, 'banana', '4 pieces, sliced diagonally (1 inch thick)', 'secondary'),
(16, 'bay leaf', '3 pieces', 'common'),
(16, 'black pepper', '1 tablespoon, whole', 'common'),
(16, 'brown sugar', '3 tablespoons', 'secondary'),
(16, 'carrot', '1 1/2 cups, sliced', 'secondary'),
(16, 'garlic', '5 tablespoons, minced', 'secondary'),
(16, 'pork belly', '3 lbs, cubed', 'main'),
(16, 'soy sauce', '3/4 cup', 'common'),
(16, 'vegetable oil', '1 cup', 'common'),
(16, 'vinegar', '1/2 cup', 'common'),
(16, 'water', '1 cup', 'common'),
(17, 'black pepper', '1/4 teaspoon, ground', 'common'),
(17, 'bread crumbs', '2 cups', 'secondary'),
(17, 'carrot', '1 large, minced', 'secondary'),
(17, 'egg', '3 pieces', 'secondary'),
(17, 'grated cheese', '1 1/2 cups, shredded sharp cheddar', 'secondary'),
(17, 'pork belly', '3 lbs, ground', 'main'),
(17, 'raisin', '2 to 4 oz.', 'secondary'),
(17, 'red bell pepper', '1 large, minced', 'secondary'),
(17, 'salt', '1 teaspoon', 'common'),
(17, 'sweet pickle relish', '3/4 to 1 cup', 'secondary'),
(17, 'water', '4 to 5 cups, for steaming', 'common'),
(17, 'yellow onion', '1 large, minced', 'secondary'),
(18, 'bay leaf', '1 piece', 'secondary'),
(18, 'black pepper', '1/4 teaspoon, cracked', 'common'),
(18, 'calamansi juice', '1/2 cup', 'common'),
(18, 'garlic', '4 cloves, peeled and minced', 'secondary'),
(18, 'liver spread', '1 can (3 ounces)', 'secondary'),
(18, 'onion', '1 piece, peeled and sliced thinly', 'secondary'),
(18, 'pork shoulder', '4 lbs, whole', 'main'),
(18, 'potato', '2 large, peeled and sliced into 1/4-inch thick rounds', 'secondary'),
(18, 'salt', 'to taste', 'common'),
(18, 'soy sauce', '1/4 cup', 'common'),
(18, 'tomato sauce', '1 cup', 'secondary'),
(18, 'vegetable oil', '1/4 cup', 'secondary'),
(18, 'water', '1 1/2 cups', 'common'),
(19, 'all purpose cream', '1/2 cup', 'secondary'),
(19, 'black pepper', 'to taste', 'common'),
(19, 'broth', '1 cup (from tongue)', 'common'),
(19, 'butter', '3 tablespoons', 'secondary'),
(19, 'corn kernel', '1 can (15.25oz), liquid drained whole', 'secondary'),
(19, 'evaporated milk', '1 can (370ml)', 'secondary'),
(19, 'garlic', '2 cloves, minced', 'secondary'),
(19, 'onion', '1 medium, chopped', 'secondary'),
(19, 'pork tongue', '1 lb', 'main'),
(19, 'salt', '1 tablespoon', 'common'),
(19, 'soy sauce', '1 tablespoon', 'common'),
(20, 'bay leaf', '4 pieces', 'secondary'),
(20, 'black pepper', '1/2 teaspoon', 'common'),
(20, 'brown sugar', '1 tablespoon (optional)', 'common'),
(20, 'garlic', '3 cloves, minced', 'secondary'),
(20, 'lechon sauce', '1 cup', 'secondary'),
(20, 'oil', '2 tablespoons', 'secondary'),
(20, 'onion', '1 medium, sliced', 'secondary'),
(20, 'pork belly', '1 kg, leftover lechon with butu-buto', 'main'),
(20, 'salt', '3/4 tablespoon', 'common'),
(20, 'vinegar', '1/4 cup', 'common'),
(20, 'water', '1 cup', 'common'),
(21, 'achuete oil', '1 tablespoon, more if making skinless sausages', 'secondary'),
(21, 'black pepper', '1 tablespoon ground', 'common'),
(21, 'brown sugar', '1/4 cup', 'common'),
(21, 'garlic', '6 cloves, crushed', 'secondary'),
(21, 'hog casing', 'optional', 'secondary'),
(21, 'pork shoulder', '0.45 kg ground', 'main'),
(21, 'salt', '1 tablespoon', 'common'),
(21, 'vegetable oil', 'for pan-frying', 'common'),
(21, 'vinegar', '1 tablespoon', 'common'),
(22, 'all purpose flour', '2/3 cup', 'secondary'),
(22, 'butter', '1/2 cup (alternative for margarine)', 'main'),
(22, 'egg', '2 whole', 'secondary'),
(22, 'margarine', '1/2 cup (alternative for butter)', 'main'),
(22, 'vanilla extract', '1 teaspoon', 'common'),
(22, 'white sugar', '1/2 cup', 'common'),
(23, 'all purpose flour', '1/4 to 2/3 cup, sifted', 'secondary'),
(23, 'butter', 'as needed (alternative for vegetable oil)', 'common'),
(23, 'egg', '5 large', 'main'),
(23, 'lemon', '1 tsp (alternative for vanilla)', 'common'),
(23, 'milk', '3/4 cup', 'main'),
(23, 'sugar', '1/2 cup', 'common'),
(23, 'vanilla', '1 tsp (alternative for rind of lemon)', 'common'),
(23, 'vegetable oil', 'as needed (alternative for butter)', 'common'),
(24, 'coconut cream', '1 cup', 'main'),
(24, 'milk', '4 cups', 'main'),
(24, 'rice flour', '1 cup', 'secondary'),
(24, 'salt', '½ teaspoon', 'common'),
(24, 'sugar', '1 cup', 'common');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `dishes`
--
ALTER TABLE `dishes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `history`
--
ALTER TABLE `history`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ingredients`
--
ALTER TABLE `ingredients`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ingredient_list`
--
ALTER TABLE `ingredient_list`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `recipe`
--
ALTER TABLE `recipe`
  ADD PRIMARY KEY (`dish_id`,`ingredient_name`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `dishes`
--
ALTER TABLE `dishes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `history`
--
ALTER TABLE `history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT for table `ingredients`
--
ALTER TABLE `ingredients`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

--
-- AUTO_INCREMENT for table `ingredient_list`
--
ALTER TABLE `ingredient_list`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=115;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `recipe`
--
ALTER TABLE `recipe`
  ADD CONSTRAINT `recipe_ibfk_1` FOREIGN KEY (`dish_id`) REFERENCES `dishes` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
