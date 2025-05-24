class AddFieldsToExchanges < ActiveRecord::Migration[7.1]
  def change
    add_column :exchanges, :accepted, :boolean, default: false
    add_column :exchanges, :seen, :boolean, default: false
  end
end
