class AddPostedOnToMeals < ActiveRecord::Migration[7.1]
  def change
    add_column :meals, :posted_on, :date
  end
end
