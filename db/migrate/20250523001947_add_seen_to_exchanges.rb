class AddSeenToExchanges < ActiveRecord::Migration[7.1]
  def change
    add_column :exchanges, :seen_status, :boolean, default: true
  end
end
