class RemoveMealFromMessages < ActiveRecord::Migration[7.1]
  def change
    remove_reference :messages, :meal, null: false, foreign_key: true
  end
end
