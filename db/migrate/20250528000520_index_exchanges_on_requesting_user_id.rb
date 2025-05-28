class IndexExchangesOnRequestingUserId < ActiveRecord::Migration[7.1]
  def change
    add_reference :exchanges, :requesting_user_id, foreign_key: { to_table: :users }
  end
end
