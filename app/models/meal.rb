class Meal < ApplicationRecord
  belongs_to :user, optional: true
end
