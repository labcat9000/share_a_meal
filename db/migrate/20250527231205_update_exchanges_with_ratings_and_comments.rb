class UpdateExchangesWithRatingsAndComments < ActiveRecord::Migration[7.1]
  def change
    change_table :exchanges do |t|
      # Remove old rating columns if they exist
      t.remove :offering_user_rating, :requesting_user_rating if column_exists?(:exchanges, :offering_user_rating) && column_exists?(:exchanges, :requesting_user_rating)

      # Add new integer rating columns
      t.integer :offering_user_rating
      t.integer :requesting_user_rating

      # Add new text comment columns
      t.text :offering_user_comment
      t.text :requesting_user_comment
    end
  end
end
