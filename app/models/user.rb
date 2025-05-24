class User < ApplicationRecord
  has_many :meals
  has_many :exchanges
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  def owner?
    role == 'owner'
  end

  def consumer?
    role == 'consumer'
  end

  def name
    "#{first_name} #{last_name}"
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :meals, dependent: :destroy
end
