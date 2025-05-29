class Exchange < ApplicationRecord
  belongs_to :meal_requested, class_name: "Meal", foreign_key: "meal_requested_id"
  belongs_to :meal_offered, class_name: "Meal", foreign_key: "meal_offered_id"
  belongs_to :requesting_user, class_name: "User", foreign_key: "requesting_user_id"


  validates :meal_requested_id, presence: true
  validates :meal_offered_id, presence: true
  validates :requesting_user_id, presence: true

  validates :offering_user_rating,
            numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 },
            allow_nil: true

  validates :requesting_user_rating,
            numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 },
            allow_nil: true

  before_validation :set_default_status, on: :create

  def rated_by_offering_user?
    offering_user_rating.present?
  end

  def rated_by_requesting_user?
    requesting_user_rating.present?
  end

  private

  def set_default_status
    self.status ||= "pending"
  end
end
