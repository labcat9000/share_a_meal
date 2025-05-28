class MealRating < ApplicationRecord
  belongs_to :meal
  belongs_to :user

  validates :value, presence: true, inclusion: { in: 1..5 }
end
