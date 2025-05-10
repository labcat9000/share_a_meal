# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require "open-uri"

Meal.destroy_all
puts "Destroyed all meals"
User.destroy_all
puts "Destroyed all users"
Exchange.destroy_all
puts "Destroyed all exchanges"

user = User.create!(email: "test@mail.com", password: "123456")
puts "Created one user"
file1 = URI.parse("https://res.cloudinary.com/docupi6qo/image/upload/v1745686057/zfede2z6jtf44gmszjou.webp").open
meal1 = Meal.create!(
  name: "Veggie Omelet",
  description: "An easy veggie omelet that takes 10mins to make",
  ingredients: "spinach, salt, pepper, onion, red bell pepper, mushrooms, eggs, milk",
  category: "Healthy",
  cuisine: "eggs",
  user: user
)

meal1.save


file2 = URI.parse("https://res.cloudinary.com/docupi6qo/image/upload/v1745686057/zfede2z6jtf44gmszjou.webp").open
meal2 = Meal.create!(
  name: "Krispy Kreme Donut",
  description: "Krispy Kreme Donut, made in 2hours",
  ingredients: "Yeast, Water, Sugar, salt, eggs, butter, flour, oil, milk, vanilla",
  category: "Sweets",
  cuisine: "Snack, dessert, donuts",
  user: user
)

meal2.save

file3 = URI.parse("https://res.cloudinary.com/docupi6qo/image/upload/v1745686057/zfede2z6jtf44gmszjou.webp").open
meal3 = Meal.create!(
  name: "Lemon Pepper Chicken Breasts",
  description: "Prep 15 mins | Ready in 1 hour 15 mins",
  ingredients: "long grain white rice, chicken, chicken broth, mccormick california style lemon pepper, butter",
  category: "Dinner",
  cuisine: "Chicken, comfort-food",
  user: user
)

meal3.save

file4 = URI.parse("https://res.cloudinary.com/docupi6qo/image/upload/v1745686057/zfede2z6jtf44gmszjou.webp").open
meal4 = Meal.create!(
  name: "Creamy Burrito Casserole",
  description: "Prep 20 mins | Ready in 50 mins",
  ingredients: "beef, onion, taco seasoning, tortillas, refried beans, cheese, sour cream, hot sauce/salsa",
  category: "Dinner",
  cuisine: "Tacos, Mexican, Beef",
  user: user
)

meal4.save

puts "Created four meals"
