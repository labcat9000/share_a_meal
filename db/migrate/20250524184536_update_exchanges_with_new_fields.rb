class UpdateExchangesWithNewFields < ActiveRecord::Migration[7.1]
  def change
    change_table :exchanges do |t|
      t.remove :rating, :user_id
      t.string :offering_user_rating, :requesting_user_rating
    end
  end
end
