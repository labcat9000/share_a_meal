# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Exchange.destroy_all
puts "Destroyed all exchanges"

Meal.destroy_all
puts "Destroyed all meals"

# Create one user who owns all meals
user = User.find_or_create_by!(email: "annarouss@gmail.com") do |u|
  u.first_name = "Ana"
  u.last_name = "Rouss"
  u.password = "password"
end

puts "Created chef user"

user2 = User.find_or_create_by!(email: "kaiisi@gmail.com") do |u|
  u.first_name = "Kai"
  u.last_name = "Isidro"
  u.password = "123456"
end

puts "Created second user"

meal1 = Meal.create!(
  name: "Poutine",
  description: "Classic Quebec dish with fries, cheese curds, and gravy.",
  category: "Dinner",
  ingredients: "Potatoes, Cheese Curds, Gravy",
  cuisine: "Quebecois",
  address: "Plateau-Mont-Royal, Montreal, QC",
  latitude: 45.5231,
  longitude: -73.5817,
  user: user
)

meal2 = Meal.create!(
  name: "Sushi",
  description: "Fresh sushi rolls made in Rosemont.",
  category: "Lunch",
  ingredients: "Rice, Fish, Seaweed",
  cuisine: "Japanese",
  address: "Rosemont–La Petite-Patrie, Montreal, QC",
  latitude: 45.5451,
  longitude: -73.5983,
  user: user2
)

Meal.create!(
  name: "Pho",
  description: "Vietnamese noodle soup with beef broth.",
  category: "Side",
  ingredients: "Beef, Noodles, Herbs",
  cuisine: "Vietnamese",
  address: "Ville-Marie, Montreal, QC",
  latitude: 45.5074,
  longitude: -73.5547,
  user: user
)

Meal.create!(
  name: "Tacos",
  description: "Delicious tacos in Outremont.",
  category: "Snack",
  ingredients: "Tortilla, Beef, Cheese",
  cuisine: "Mexican",
  address: "Outremont, Montreal, QC",
  latitude: 45.5208,
  longitude: -73.6056,
  user: user2
)

Meal.create!(
  name: "Pizza",
  description: "Wood-fired pizza in Verdun.",
  category: "Lunch",
  ingredients: "Dough, Tomato, Mozzarella",
  cuisine: "Italian",
  address: "Verdun, Montreal, QC",
  latitude: 45.4583,
  longitude: -73.5672,
  user: user
)

Meal.create!(
  name: "Kebab",
  description: "Grilled kebab served in Hochelaga.",
  category: "Dinner",
  ingredients: "Lamb, Onion, Spices",
  cuisine: "Middle Eastern",
  address: "Hochelaga-Maisonneuve, Montreal, QC",
  latitude: 45.5500,
  longitude: -73.5400,
  user: user2
)

Meal.create!(
  name: "Lasagna",
  description: "Home-style lasagna from Côte-des-Neiges.",
  category: "Dinner",
  ingredients: "Pasta, Tomato Sauce, Cheese",
  cuisine: "Italian",
  address: "Côte-des-Neiges, Montreal, QC",
  latitude: 45.4998,
  longitude: -73.6274,
  user: user
)

Meal.create!(
  name: "Ramen",
  description: "Hot and comforting ramen bowl.",
  category: "Snack",
  ingredients: "Broth, Noodles, Pork",
  cuisine: "Japanese",
  address: "Villeray, Montreal, QC",
  latitude: 45.5461,
  longitude: -73.6206,
  user: user2
)

Meal.create!(
  name: "Paella",
  description: "Seafood paella in Lachine.",
  category: "Side",
  ingredients: "Rice, Seafood, Saffron",
  cuisine: "Spanish",
  address: "Lachine, Montreal, QC",
  latitude: 45.4312,
  longitude: -73.6757,
  user: user
)

Meal.create!(
  name: "Fajitas",
  description: "Sizzling fajitas from Saint-Laurent.",
  category: "Lunch",
  ingredients: "Chicken, Peppers, Onion",
  cuisine: "Tex-Mex",
  address: "Saint-Laurent, Montreal, QC",
  latitude: 45.5023,
  longitude: -73.6987,
  user: user2
)

puts "Created 10 meals across different boroughs"

exchange1 = Exchange.create!(
  meal_offered_id: meal1.id,
  meal_requested_id: meal2.id,
  requesting_user: user2
)

puts "Created 1 exchange"
