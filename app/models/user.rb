class User < ApplicationRecord
  has_many :meals, dependent: :destroy

  # Exchanges where this user is the one requesting a meal
  has_many :requested_exchanges, class_name: "Exchange", foreign_key: "requesting_user_id"

  # Exchanges involving meals this user owns (i.e., they are offering)
  has_many :offered_exchanges, through: :meals, source: :offered_exchanges

  has_one_attached :profile_photo, dependent: :purge_later

  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def owner?
    role == 'owner'
  end

  def consumer?
    role == 'consumer'
  end

  def name
    "#{first_name} #{last_name}"
  end

  def average_combined_rating
    ratings = meals.map do |meal|
      meal.average_combined_rating unless meal.average_combined_rating == "No ratings yet"
    end.compact.map(&:to_f)

    return "No ratings yet" if ratings.empty?

    (ratings.sum / ratings.size).round(2)
  end

  # Optional: Get all exchanges involving this user
  def all_related_exchanges
    Exchange.where(
      "requesting_user_id = :user_id OR meal_offered_id IN (:meal_ids)",
      user_id: id,
      meal_ids: meals.pluck(:id)
    )
  end
end
