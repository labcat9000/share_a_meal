class User < ApplicationRecord
  has_many :meals, dependent: :destroy
  has_many :exchanges
  has_one_attached :profile_photo

  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Custom roles
  def owner?
    role == 'owner'
  end

  def consumer?
    role == 'consumer'
  end

  def name
    "#{first_name} #{last_name}"
  end
end
