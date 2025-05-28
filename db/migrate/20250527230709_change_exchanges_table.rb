class ChangeExchangesTable < ActiveRecord::Migration[7.1]
  def change
    change_table :exchanges do |t|
      t.bigint :requesting_user_id
    end
  end
end
