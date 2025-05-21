class MealsController < ApplicationController
  before_action :set_meal, only: [:show, :edit, :update, :destroy]

  def index
    @meals_by_name = Meal.all
    @meals_by_ingredients = []

    if params[:query].present?
      query = "%#{params[:query]}%"
      @meals_by_name = Meal.where("name ILIKE ? OR description ILIKE ?", query, query)

      if @meals_by_name.empty?
        @meals_by_ingredients = Meal.where("ingredients ILIKE ?", query)
      end
    end

    # Filtering after search so filters apply to all matching results
    if params[:category].present?
      @meals_by_name = @meals_by_name.where(category: params[:category])
      @meals_by_ingredients = @meals_by_ingredients.where(category: params[:category]) if @meals_by_ingredients.any?
    end

    if params[:cuisine].present?
      @meals_by_name = @meals_by_name.where(cuisine: params[:cuisine])
      @meals_by_ingredients = @meals_by_ingredients.where(cuisine: params[:cuisine]) if @meals_by_ingredients.any?
    end
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
