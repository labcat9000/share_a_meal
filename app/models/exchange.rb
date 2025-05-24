class Exchange < ApplicationRecord
  belongs_to :meal # the requested meal
  belongs_to :meal_requested, class_name: "Meal", foreign_key: "meal_requested_id"
  belongs_to :meal_offered, class_name: "Meal", foreign_key: "meal_offered_id"
  belongs_to :user

  validates :meal_offered, presence: true
  validates :meal_requested, presence: true

  before_validation :set_default_status, on: :create

  private

  def set_default_status
    self.status ||= "pending"
  end
end
