Exchange.destroy_all
puts "Destroyed all exchanges"

Meal.destroy_all
puts "Destroyed all meals"

User.destroy_all
puts "Destroyed all users"

user1 = User.create!(
  first_name: "Henrique",
  last_name: "Vera",
  email: "henrique@mail.com",
  password: "password",
  address: "5333 Casgrain Ave, Montreal, QC H2T 1X3"
)
puts "Created user Henrique"

Meal.create!(
  name: "Roasted Red Pepper Egg Muffins",
  description: "Mini egg-muffins with roasted red pepper and green onions.",
  category: "Breakfast",
  ingredients: "Eggs, oil, roasted red pepper from jar, green onions, salt, pepper, mozzarella cheese",
  cuisine: "",
  user: user1,
  address: user1.address
)

Meal.create!(
  name: "Peanut Butter Cookies",
  description: "Classic cookie recipe made with smooth peanut butter and baked in the oven.",
  category: "Dessert",
  ingredients: "Butter, peanut butter, sugar, eggs, flour, baking powder, salt",
  cuisine: "",
  user: user1,
  address: user1.address
)

Meal.create!(
  name: "Cabbage Rolls in Tomato Sauce",
  description: "Cabbage leaves rolled up with a filling of rice, beef, and pork. Stewed in tomato sauce for a hearty and complete meal. Delicious and made with love.",
  category: "Dinner",
  ingredients: "Cabbage, beef, pork, onion, rice, parsley, dill, salt, cayenne, tomatoes, tomato sauce, sugar",
  cuisine: "European",
  user: user1,
  address: user1.address
)

puts "Created Henrique's meals"

user2 = User.create!(
  first_name: "Kai",
  last_name: "Isidro",
  email: "kai@mail.com",
  password: "123456",
  address: "487 St Joseph Blvd E, Montreal, QC H2J 1J8"
)
puts "Created user Kai"

Meal.create!(
  name: "Strawberry-Oat Breakfast Bars",
  description: "Baked breakfast bars made with oats, greek yogurt, and frozen strawberries",
  category: "Breakfast",
  ingredients: "Oats, Strawberries, Greek yogurt, cinnamon",
  cuisine: "",
  address: "Rosemont–La Petite-Patrie, Montreal, QC",
  latitude: 45.5451,
  longitude: -73.5983,
  user: user2,
  address: user2.address
)

puts "Created Kai's meal"

user3 = User.create!(
  first_name: "Mikey",
  last_name: "Row",
  email: "mrow@mail.com",
  password: "123456",
  address: "255 Saint Viateur St. West, Montreal, QC H2V 1Y1"
)
puts "Created user Mikey"

Meal.create!(
  name: "Poutine",
  description: "Classic Quebec dish with fries, cheese curds, and gravy.",
  category: "Dinner",
  ingredients: "Potatoes, Cheese Curds, Gravy",
  cuisine: "Quebecois",
  user: user3,
  address: user3.address
)

Meal.create!(
  name: "Coconut Chia Pudding",
  description: "A lightly sweetened chia pudding made with coconut milk and maple syrup",
  category: "Breakfast",
  ingredients: "Chia seeds, coconut milk, dried coconut, maple syrup",
  cuisine: "",
  user: user3,
  address: user3.address
)

Meal.create!(
  name: "Tacos",
  description: "Delicious tacos in Outremont.",
  category: "Snack",
  ingredients: "Tortilla, Pork, Pineapple, Spices, Cheese",
  cuisine: "Mexican",
  user: user3,
  address: user3.address
)

puts "Created Mikey's meals"

user4 = User.create!(
  first_name: "Alexa",
  last_name: "Amos",
  email: "aamos@mail.com",
  password: "123456",
  address: "4692 Rue de Grand-Pré, Montreal, QC H2T 2H7"
)
puts "Created user Alexa"

Meal.create!(
  name: "Tofu Stir-Fry with Brown Rice",
  description: "Vegan stir-fry with tofu and carrots",
  category: "Lunch",
  ingredients: "Tofu, carrots, ginger, cabbage, onions, scallions, soy sauce, sesame oil",
  cuisine: "",
  user: user4,
  address: user4.address
)

Meal.create!(
  name: "Savory Trail Mix",
  description: "Crunchy trail mix with nuts",
  category: "Snack",
  ingredients: "Corn chex cereal, rice chex cereal, butter, BBQ seasoning, roasted peanuts, roasted almonds, pretzel sticks, corn chips",
  cuisine: "",
  user: user4,
  address: user4.address
)

Meal.create!(
  name: "Vegetable Curry",
  description: "A bright mix of veggies including zucchini, bell pepper, and cauliflower in a flavorful curry sauce. Served over basmati rice.",
  category: "Dinner",
  ingredients: "Crushed tomato, zucchini, okra, bell pepper, cauliflower, onion, garlic, vegetable broth, coriander, curry powder, cayenne, cumin, nutmeg, paprika, salt, pepper",
  cuisine: "Indian",
  user: user4,
  address: user4.address
)

puts "Created Alexa's meals"

user5 = User.create!(
  first_name: "Mark",
  last_name: "Joshua",
  email: "mjosh@mail.com",
  password: "123456",
  address: "4274 Rue De Bullion, Montréal, QC H2W 2E7"
)
puts "Created user Mark"

Meal.create!(
  name: "Stuffed Green Bell Peppers",
  description: "Green bell peppers hollowed out and baked with a sausage and rice filling then topped with cheese.",
  category: "Dinner",
  ingredients: "Green bell pepper, white rice, spicy Italian sausage, onion, garlic, salt, white pepper, mozzarella cheese",
  cuisine: "",
  user: user5,
  address: user5.address
)

Meal.create!(
  name: "Lamb Kebab",
  description: "Grilled kebab served with roasted potatoes and green salad.",
  category: "Lunch",
  ingredients: "Lamb, Onion, Spices, Oil, Rice, Iceberg Lettuce",
  cuisine: "Middle Eastern",
  user: user5,
  address: user5.address
)

user6 = User.create!(
  first_name: "Bart",
  last_name: "Tholemew",
  email: "btholjosh@mail.com",
  password: "123456",
  address: "92 Av. Laurier O, Montréal, QC H2T 2N4"
)
puts "Created user Bart"

Meal.create!(
  name: "Mini Charcuterie Box",
  description: "An assortment of charcuterie ingredients in a little snack tray. Includes meat, cheese, crackers, fruit, pickles, and nuts.",
  category: "Snack",
  ingredients: "Multigrain crackers, table crackers, cheddar cheese, salami, ham, grapes, dried cranberries, cornichons, roasted almonds",
  cuisine: "",
  user: user6,
  address: user6.address
)

Meal.create!(
  name: "Lasagna",
  description: "Home-style lasagna made with beef, pork, and veal.",
  category: "Dinner",
  ingredients: "Pasta, Beef, Pork, Veal, Tomato Sauce, Cheese",
  cuisine: "Italian",
  user: user6,
  address: user6.address
)

user7 = User.create!(
  first_name: "Sean",
  last_name: "Won",
  email: "swon@mail.com",
  password: "123456",
  address: "4117 St Laurent Blvd, Montreal, QC H2W 1Y7"
)
puts "Created user Sean"

Meal.create!(
  name: "Chicken Burrito Bowl with Avocado",
  description: "Shredded chicken in a bowl with black beans, tomato rice, tomatoes, corn, and cheese. Each portion includes a half avocado.",
  category: "Lunch",
  ingredients: "Chicken, rice, tomato, corn, onion, cilantro, cheese, avocado",
  cuisine: "Tex-Mex",
  user: user7,
  address: user7.address
)

Meal.create!(
  name: "Turkey Chili",
  description: "Chili with ground turkey, beans, and bacon",
  category: "Lunch",
  ingredients: "Crushed tomatoes, ground turkey, bacon, red kidney beans, garlic, onion, dried herbs, spices",
  cuisine: "",
  user: user7,
  address: user7.address
)

Meal.create!(
  name: "Marinated Bean Salad",
  description: "Mixed bean side salad with herby oil and vinegar dressing",
  category: "Side",
  ingredients: "Kidney beans, chickpeas, pinto beans, olive oil, fresh thyme, dried oregano, onion, tomato",
  cuisine: "",
  user: user7,
  address: user7.address
)

user8 = User.create!(
  first_name: "Amiee",
  last_name: "Chorchill",
  email: "achorch@mail.com",
  password: "123456",
  address: "5854 Av. De Chateaubriand, Montréal, QC H2S 2N2"
)
puts "Created user Aimee"

Meal.create!(
  name: "Beef Stew",
  description: "Traditional beef stew made with onion, carrot, bell pepper, and potatoes. Deglazed with red wine.",
  category: "Dinner",
  ingredients: "Beef, beef broth, red wine, onion, carrot, garlic, bell pepper, potatoes, thyme, salt, black pepper",
  cuisine: "European",
  user: user8,
  address: user8.address
)

Meal.create!(
  name: "Fruit Salad with Lime and Mint",
  description: "A summery chopped-fruit salad.",
  category: "Dessert",
  ingredients: "Watermelon, cantaloupe, apple, pear, honey, lime, mint",
  cuisine: "",
  user: user8,
  address: user8.address
)

user9 = User.create!(
  first_name: "Oscar",
  last_name: "Grundy",
  email: "ogrundy@mail.com",
  password: "123456",
  address: "1060 Rue Gilford, Montréal, QC H2J 1P6"
)
puts "Created user Oscar"

Meal.create!(
  name: "Creamy Chicken Pasta Bake ",
  description: "Fettuccine Alfredo with chicken breast baked into a casserole. Served with a side of cooked spinach.",
  category: "Dinner",
  ingredients: "Pasta, cream, Parmesan cheese, garlic, chicken breast, salt, pepper, olive oil, spinach",
  cuisine: "American",
  user: user9,
  address: user9.address
)

Meal.create!(
  name: "Greek Salad",
  description: "Simple and fresh Greek salad with cucumber, tomato, and feta cheese.",
  category: "Side",
  ingredients: "Cucumber, tomato, onion, feta, olive oil, vinegar",
  cuisine: "Greek",
  user: user9,
  address: user9.address
)

puts "Done seeding"
