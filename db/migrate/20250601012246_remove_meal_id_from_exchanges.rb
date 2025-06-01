class RemoveMealIdFromExchanges < ActiveRecord::Migration[7.1]
  def change
    remove_column :exchanges, :meal_id, :bigint
  end
end
