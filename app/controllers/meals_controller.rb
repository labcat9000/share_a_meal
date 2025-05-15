class MealsController < ApplicationController
  def index
    @meals = Meal.all
  end

  def show
    @meal = Meal.find_by(id: params[:id])
    if @meal.nil?
      redirect_to meals_path, alert: "Meal not found."
    end
  end
end
