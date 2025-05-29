# app/policies/meal_policy.rb
class MealPolicy < ApplicationPolicy
  def show?
    true # or whatever logic you want, e.g., record.user == user
  end

  def new?
    user.present?
  end

  def create?
    user.present?
  end

  def edit?
    user_is_owner?
  end

  def update?
    user_is_owner?
  end

  def destroy?
    user_is_owner?
  end

  def remove_photo?
    user_is_owner?
  end


  private

  def user_is_owner?
    record.user == user
  end

  # Add more methods as needed (e.g., create?, index?, etc.)
end
