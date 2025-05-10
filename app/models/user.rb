class User < ApplicationRecord
  has_many :meals
  has_many :exchanges
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  def meal_owner?
    role == 'owner'
  end

  def exchanger?
    role == 'exchanger'
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
