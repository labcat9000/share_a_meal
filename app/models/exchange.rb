class Exchange < ApplicationRecord
  # belongs_to :meal # the requested meal
  belongs_to :meal_requested, class_name: "Meal", foreign_key: "meal_requested_id"
  # belongs_to :meal_offered, class_name: "Meal", foreign_key: "meal_offered_id"
  # belongs_to :user

  validates :meal_requested_id, presence: true
  validates :requesting_user_id, presence: true
  validates :meal_offered_id, presence: true
  validates :offering_user_rating, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }, allow_nil: true
  validates :requesting_user_rating, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }, allow_nil: true

#   validate :no_overlapping_exchanges
#   validate :only_one_exchange_per_user_meal

  before_validation :set_default_status, on: :create

  def rated_by_offering_user?
    offering_user_rating.present?
  end

  def rated_by_requesting_user?
    requesting_user_rating.present?
  end

  def average_rating
    ratings = [offering_user_rating, requesting_user_rating].compact
    return nil if ratings.empty?

    (ratings.sum.to_f / ratings.size).round(2)
  end

  private

  def set_default_status
    self.status ||= "pending"
  end

#   #not the same date
#   def no_overlapping_exchanges

#     overlaps = Exchange.where(meal_offered_id: meal_offered, status: "accepted")
#                       .where.not(id: id)

#     if overlaps.exists?
#       errors.add(:base, "This meal has already been shared")
#     end
#   end

#   #not 2 bookings for the same user and tool
#   def only_one_exchange_per_user_meal

#     existing_exchange = Exchange.where(user_id: user_id, meal_offered_id: meal_offered)
#                                .where.not(id: id)

#     if existing_exchange.exists?
#       errors.add(:base, "You already have a share for this meal.")
#     end
#   end
end
