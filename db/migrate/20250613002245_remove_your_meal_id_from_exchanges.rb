class RemoveYourMealIdFromExchanges < ActiveRecord::Migration[7.1]
  def change
    remove_column :exchanges, :your_meal_id, :bigint
  end
end
