class CreateMealRatings < ActiveRecord::Migration[7.1]
  def change
    create_table :meal_ratings do |t|
      t.integer :value
      t.references :meal, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
