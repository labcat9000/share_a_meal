class IndexExchangesOnRequestingUser < ActiveRecord::Migration[7.1]
  def change
    remove_reference :exchanges, :requesting_user_id
    remove_column :exchanges, :requesting_user_id, :bigint
    add_reference :exchanges, :requesting_user
  end
end
