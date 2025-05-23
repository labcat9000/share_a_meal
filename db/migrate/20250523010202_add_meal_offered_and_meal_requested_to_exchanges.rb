class AddMealOfferedAndMealRequestedToExchanges < ActiveRecord::Migration[7.1]
  def change
    add_reference :exchanges, :meal_offered, foreign_key: { to_table: :meals }
    add_reference :exchanges, :meal_requested, foreign_key: { to_table: :meals }
    remove_reference :exchanges, :meal
  end
end
