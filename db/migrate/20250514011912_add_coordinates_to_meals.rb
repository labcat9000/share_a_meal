class AddCoordinatesToMeals < ActiveRecord::Migration[7.1]
  def change
    add_column :meals, :latitude, :float
    add_column :meals, :longitude, :float
  end
end
