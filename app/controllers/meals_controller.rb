class MealsController < ApplicationController
  before_action :set_meal, only: [:show, :edit, :update, :destroy]

  def index
    @meals = params[:query].present? ? Meal.search(params[:query]) : Meal.all
  end

  def show
    @meal = Meal.find_by(id: params[:id])
    if @meal.nil?
      redirect_to meals_path, alert: "Meal not found."
    end
  end

  def new
    @meal = Meal.new
  end

  def create
    @meal = Meal.new(meal_params)
    if @meal.save
      redirect_to meals_path, notice: 'Meal was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @meal.update(meal_params)
      redirect_to meals_path, notice: 'Meal was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @meal.destroy
    redirect_to meals_path, notice: 'Meal was successfully deleted.'
  end

  private

  def set_meal
    @meal = Meal.find(params[:id])
  end

  def meal_params
    params.require(:meal).permit(:name, :description, :ingredients, :category, :cuisine) # Add any other fields
  end
end
