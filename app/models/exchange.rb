class Exchange < ApplicationRecord
  belongs_to :user
  belongs_to :meal

  validate :no_overlapping_exchangings
  validate :only_one_exchanging_per_user_meal

  before_validation :set_default_status, on: :create

  private


  def set_default_status
    self.status ||= "pending"
  end

  #not the same date
  def no_overlapping_exchanges

    overlaps = Exchange.where(meal_id: meal_id, status: "accepted")
                      .where.not(id: id)

    if overlaps.exists?
      errors.add(:base, "This meal is already exchanged")
    end
  end

  #not 2 bookings for the same user and tool
  def only_one_exchange_per_user_meal

    existing_exchange = Exchange.where(user_id: user_id, meal_id: meal_id)
                               .where.not(id: id)

    if existing_exchange.exists?
      errors.add(:base, "You already have an exchange for this meal.")
    end
  end
end
