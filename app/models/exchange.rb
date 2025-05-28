class Exchange < ApplicationRecord
  # belongs_to :meal # the requested meal
  belongs_to :meal_requested, class_name: "Meal", foreign_key: "meal_requested_id"
  # belongs_to :meal_offered, class_name: "Meal", foreign_key: "meal_offered_id"
  # belongs_to :user

  validates :meal_requested_id, presence: true
  validates :requesting_user_id, presence: true

#   validate :no_overlapping_exchanges
#   validate :only_one_exchange_per_user_meal

  before_validation :set_default_status, on: :create

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
