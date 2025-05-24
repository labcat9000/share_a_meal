class AddAddressToMeals < ActiveRecord::Migration[7.1]
  def change
    add_column :meals, :address, :string
  end
end
