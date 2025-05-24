class Meal < ApplicationRecord
  belongs_to :user, optional: true
  has_one_attached :photo

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  validates :name, presence: true
  validates :description, presence: true

  scope :available, -> {
    where.not(id: Exchange.select(:meal_offered_id))
  }

  def average_rating
    ratings.average(:value)&.round(1) || "No ratings yet"
  end

  def self.search(query)
    where("name ILIKE ? OR description ILIKE ?", "%#{query}%", "%#{query}%")
  end
end
