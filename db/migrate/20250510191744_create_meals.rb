class CreateMeals < ActiveRecord::Migration[7.1]
  def change
    create_table :meals do |t|
      t.string :name
      t.text :description
      t.text :ingredients
      t.string :category
      t.string :cuisine

      t.timestamps
    end
  end
end
