class User < ApplicationRecord
  has_many :meals, dependent: :destroy
  has_many :exchanges
  has_one_attached :profile_photo

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
end
