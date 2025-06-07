Exchange.destroy_all
puts "Destroyed all exchanges"

Meal.destroy_all
puts "Destroyed all meals"

user1 = User.create!(
  first_name: "Henrique",
  last_name: "Vera",
  email: "henrique@mail.com",
  password: "password"
)
puts "Created user Henrique"

user2 = User.create!(
  first_name: "Kai",
  last_name: "Isidro",
  email: "kai@mail.com",
  password: "123456"
)
puts "Created user Kai"

user3 = User.create!(
  first_name: "Mikey",
  last_name: "Row",
  email: "mrow@mail.com",
  password: "123456"
)
puts "Created user Mikey"

user4 = User.create!(
  first_name: "Alexa",
  last_name: "Amos",
  email: "aamos@mail.com",
  password: "123456"
)
puts "Created user Alexa"

meal1 = Meal.create!(
  name: "Poutine",
  description: "Classic Quebec dish with fries, cheese curds, and gravy.",
  category: "Dinner",
  ingredients: "Potatoes, Cheese Curds, Gravy",
  cuisine: "Quebecois",
  address: "Plateau-Mont-Royal, Montreal, QC",
  latitude: 45.5231,
  longitude: -73.5817,
  user: user3
)

meal2 = Meal.create!(
  name: "Strawberry-Oat Breakfast Bars",
  description: "Baked breakfast bars made with oats, greek yogurt, and frozen strawberries",
  category: "Breakfast",
  ingredients: "Oats, Strawberries, Greek yogurt, cinnamon",
  cuisine: "",
  address: "Rosemont–La Petite-Patrie, Montreal, QC",
  latitude: 45.5451,
  longitude: -73.5983,
  user: user2
)

Meal.create!(
  name: "Coconut Chia Pudding",
  description: "A lightly sweetened chia pudding made with coconut milk and maple syrup",
  category: "Breakfast",
  ingredients: "Chia seeds, coconut milk, dried coconut, maple syrup",
  cuisine: "",
  address: "Ville-Marie, Montreal, QC",
  latitude: 45.5074,
  longitude: -73.5547,
  user: user3
)

Meal.create!(
  name: "Tacos",
  description: "Delicious tacos in Outremont.",
  category: "Snack",
  ingredients: "Tortilla, Pork, Pineapple, Spices, Cheese",
  cuisine: "Mexican",
  address: "Outremont, Montreal, QC",
  latitude: 45.5208,
  longitude: -73.6056,
  user: user3
)

Meal.create!(
  name: "Roasted Red Pepper Egg Muffins",
  description: "Mini egg-muffins with roasted red pepper and green onions.",
  category: "Breakfast",
  ingredients: "Eggs, oil, roasted red pepper from jar, green onions, salt, pepper, mozzarella cheese",
  cuisine: "",
  address: "Verdun, Montreal, QC",
  latitude: 45.4583,
  longitude: -73.5672,
  user: user1
)

Meal.create!(
  name: "Lamb Kebab",
  description: "Grilled kebab served with roasted potatoes and green salad.",
  category: "Lunch",
  ingredients: "Lamb, Onion, Spices, Oil, Rice, Iceberg Lettuce",
  cuisine: "Middle Eastern",
  address: "Hochelaga-Maisonneuve, Montreal, QC",
  latitude: 45.5500,
  longitude: -73.5400,
  user: user3
)

Meal.create!(
  name: "Lasagna",
  description: "Home-style lasagna made with beef, pork, and veal.",
  category: "Dinner",
  ingredients: "Pasta, Beef, Pork, Veal, Tomato Sauce, Cheese",
  cuisine: "Italian",
  address: "Côte-des-Neiges, Montreal, QC",
  latitude: 45.4998,
  longitude: -73.6274,
  user: user3
)

Meal.create!(
  name: "Chicken Burrito Bowl with Avocado",
  description: "Shredded chicken in a bowl with black beans, tomato rice, tomatoes, corn, and cheese. Each portion includes a half avocado.",
  category: "Lunch",
  ingredients: "Chicken, rice, tomato, corn, onion, cilantro, cheese, avocado",
  cuisine: "Tex-Mex",
  address: "Villeray, Montreal, QC",
  latitude: 45.5461,
  longitude: -73.6206,
  user: user3
)

Meal.create!(
  name: "Mini Charcuterie Box",
  description: "An assortment of charcuterie ingredients in a little snack tray. Includes meat, cheese, crackers, fruit, pickles, and nuts.",
  category: "Snack",
  ingredients: "Multigrain crackers, table crackers, cheddar cheese, salami, ham, grapes, dried cranberries, cornichons, roasted almonds",
  cuisine: "",
  address: "Lachine, Montreal, QC",
  latitude: 45.4312,
  longitude: -73.6757,
  user: user4
)

Meal.create!(
  name: "Tofu Stir-Fry with Brown Rice",
  description: "Vegan stir-fry with tofu and carrots",
  category: "Lunch",
  ingredients: "Tofu, carrots, ginger, cabbage, onions, scallions, soy sauce, sesame oil",
  cuisine: "",
  address: "Saint-Laurent, Montreal, QC",
  latitude: 45.5023,
  longitude: -73.6987,
  user: user4
)

Meal.create!(
  name: "Turkey Chili",
  description: "Chili with ground turkey, beans, and bacon",
  category: "Lunch",
  ingredients: "Crushed tomatoes, ground turkey, bacon, red kidney beans, garlic, onion, dried herbs, spices",
  cuisine: "",
  address: "Saint-Laurent, Montreal, QC",
  latitude: 45.5023,
  longitude: -73.6987,
  user: user3
)

Meal.create!(
  name: "Savory Trail Mix",
  description: "Crunchy trail mix with nuts",
  category: "Snack",
  ingredients: "Corn chex cereal, rice chex cereal, butter, BBQ seasoning, roasted peanuts, roasted almonds, pretzel sticks, corn chips",
  cuisine: "",
  address: "Saint-Laurent, Montreal, QC",
  latitude: 45.5023,
  longitude: -73.6987,
  user: user4
)

Meal.create!(
  name: "Marinated Bean Salad",
  description: "Mixed bean side salad with herby oil and vinegar dressing",
  category: "Side",
  ingredients: "Kidney beans, chickpeas, pinto beans, olive oil, fresh thyme, dried oregano, onion, tomato",
  cuisine: "",
  address: "Saint-Laurent, Montreal, QC",
  latitude: 45.5023,
  longitude: -73.6987,
  user: user3
)

Meal.create!(
  name: "Greek Salad",
  description: "Simple and fresh Greek salad with cucumber, tomato, and feta cheese.",
  category: "Side",
  ingredients: "Cucumber, tomato, onion, feta, olive oil, vinegar",
  cuisine: "Greek",
  address: "Saint-Laurent, Montreal, QC",
  latitude: 45.5023,
  longitude: -73.6987,
  user: user4
)

Meal.create!(
  name: "Cabbage Rolls in Tomato Sauce",
  description: "Cabbage leaves rolled up with a filling of rice, beef, and pork. Stewed in tomato sauce for a hearty and complete meal. Delicious and made with love.",
  category: "Dinner",
  ingredients: "Cabbage, beef, pork, onion, rice, parsley, dill, salt, cayenne, tomatoes, tomato sauce, sugar",
  cuisine: "European",
  address: "Saint-Laurent, Montreal, QC",
  latitude: 45.5023,
  longitude: -73.6987,
  user: user4
)

Meal.create!(
  name: "Vegetable Curry",
  description: "A bright mix of veggies including zucchini, bell pepper, and cauliflower in a flavorful curry sauce. Served over basmati rice.",
  category: "Dinner",
  ingredients: "Crushed tomato, zucchini, okra, bell pepper, cauliflower, onion, garlic, vegetable broth, coriander, curry powder, cayenne, cumin, nutmeg, paprika, salt, pepper",
  cuisine: "Indian",
  address: "Saint-Laurent, Montreal, QC",
  latitude: 45.5023,
  longitude: -73.6987,
  user: user4
)

Meal.create!(
  name: "Beef Stew",
  description: "Traditional beef stew made with onion, carrot, bell pepper, and potatoes. Deglazed with red wine.",
  category: "Dinner",
  ingredients: "Beef, beef broth, red wine, onion, carrot, garlic, bell pepper, potatoes, thyme, salt, black pepper",
  cuisine: "European",
  address: "Saint-Laurent, Montreal, QC",
  latitude: 45.5023,
  longitude: -73.6987,
  user: user3
)

Meal.create!(
  name: "Creamy Chicken Pasta Bake ",
  description: "Fettuccine Alfredo with chicken breast baked into a casserole. Served with a side of cooked spinach.",
  category: "Dinner",
  ingredients: "Pasta, cream, Parmesan cheese, garlic, chicken breast, salt, pepper, olive oil, spinach",
  cuisine: "American",
  address: "Saint-Laurent, Montreal, QC",
  latitude: 45.5023,
  longitude: -73.6987,
  user: user3
)

Meal.create!(
  name: "Stuffed Green Bell Peppers",
  description: "Green bell peppers hollowed out and baked with a sausage and rice filling then topped with cheese.",
  category: "Dinner",
  ingredients: "Green bell pepper, white rice, spicy Italian sausage, onion, garlic, salt, white pepper, mozzarella cheese",
  cuisine: "",
  address: "Saint-Laurent, Montreal, QC",
  latitude: 45.5023,
  longitude: -73.6987,
  user: user4
)

Meal.create!(
  name: "Peanut Butter Cookies",
  description: "Classic cookie recipe made with smooth peanut butter and baked in the oven.",
  category: "Dessert",
  ingredients: "Butter, peanut butter, sugar, eggs, flour, baking powder, salt",
  cuisine: "Eurpoean",
  address: "Saint-Laurent, Montreal, QC",
  latitude: 45.5023,
  longitude: -73.6987,
  user: user1
)

Meal.create!(
  name: "Fruit Salad with Lime and Mint",
  description: "A summery chopped-fruit salad.",
  category: "Dessert",
  ingredients: "Watermelon, cantaloupe, apple, pear, honey, lime, mint",
  cuisine: "",
  address: "Saint-Laurent, Montreal, QC",
  latitude: 45.5023,
  longitude: -73.6987,
  user: user3
)

puts "Created many meals across different boroughs"

puts "Done seeding"
