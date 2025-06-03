class ExchangePolicy < ApplicationPolicy
  def show?
    true # or whatever logic you want, e.g., record.user == user
  end

  def new?
    true
  end

  def create?
    true
  end

  def edit?
    true
  end

  def update?
    true
  end

  def destroy?
    true
  end

  def remove_photo?
    true
  end

  def accept?
    true
  end

  def decline?
    true
  end

  private

  def user_is_owner?
    record.user == user
  end

  # Add more methods as needed (e.g., create?, index?, etc.)
end
