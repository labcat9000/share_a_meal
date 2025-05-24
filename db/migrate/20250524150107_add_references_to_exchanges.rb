class AddReferencesToExchanges < ActiveRecord::Migration[7.1]
  def change
    add_reference :exchanges, :your_meal, null: false, foreign_key: { to_table: :meals }
  end
end
