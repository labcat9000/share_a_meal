# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'

Meal.destroy_all
puts "Destroyed all meals"

users = 6.times.map do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    phone_number: Faker::PhoneNumber.cell_phone,
    address: Faker::Address.full_address,
    email: Faker::Internet.unique.email,
    password: 'password'
  )
end

categories = ['Appetizer', 'Main Course', 'Dessert', 'Snack', 'Side Dish', 'Soup']

20.times do
  Meal.create!(
    name: Faker::Food.unique.dish,
    description: Faker::Food.description,
    category: categories.sample,
    ingredients: Array.new(rand(3..6)) { Faker::Food.ingredient }.join(', '),
    cuisine: Faker::Nation.nationality,
    user: users.sample
  )
end

puts "Created 20 meals"
