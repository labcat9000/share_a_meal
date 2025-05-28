class Meal < ApplicationRecord
  CATEGORY_OPTIONS = [
    'Breakfast',
    'Lunch',
    'Snack',
    'Side',
    'Dinner',
    'Dessert'
  ].freeze

  has_many :offered_exchanges, class_name: "Exchange", foreign_key: "meal_offered_id"
  has_many :requested_exchanges, class_name: "Exchange", foreign_key: "meal_requested_id"
  has_many :meal_ratings, class_name: "MealRating"

  belongs_to :user, optional: true
  has_many :exchanges

  has_one_attached :photo

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  validates :name, presence: true
  validates :description, presence: true
  validates :category, presence: true, inclusion: { in: CATEGORY_OPTIONS }

  scope :available, -> {
    where.not(id: Exchange.select(:meal_offered_id))
  }

  before_validation :set_default_posted_on

  def average_combined_rating
    # Get meal ratings
    meal_ratings_values = meal_ratings.pluck(:value).compact

    # Get exchange ratings
    exchange_ratings = offered_exchanges.where.not(offering_user_rating: nil).pluck(:offering_user_rating) +
                       requested_exchanges.where.not(requesting_user_rating: nil).pluck(:requesting_user_rating)

    all_ratings = meal_ratings_values + exchange_ratings

    return "No ratings yet" if all_ratings.empty?

    (all_ratings.sum.to_f / all_ratings.size).round(2)
  end

  def self.search(query)
    where("name ILIKE ? OR description ILIKE ?", "%#{query}%", "%#{query}%")
  end

  private

  def set_default_posted_on
    self.posted_on ||= Date.today
  end
end
