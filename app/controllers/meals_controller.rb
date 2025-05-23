class MealsController < ApplicationController
  before_action :set_meal, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    base_scope = Meal.all
    @meals_by_name = base_scope
    @meals_by_ingredients = []

    if params[:query].present?
      query = "%#{params[:query]}%"
      @meals_by_name = Meal.where("name ILIKE ? OR description ILIKE ? OR cuisine ILIKE ?", query, query, query)

      if @meals_by_name.empty?
        @meals_by_ingredients = Meal.where("ingredients ILIKE ? OR cuisine ILIKE ?", query, query)
      end
    end


    if params[:category].present?
      @meals_by_name = @meals_by_name.where(category: params[:category])
      @meals_by_ingredients = @meals_by_ingredients.where(category: params[:category]) if @meals_by_ingredients.any?
    end

    if params[:cuisine].present?
      pattern = "%#{params[:cuisine].strip.downcase}%"
      @meals_by_name = @meals_by_name.where("LOWER(cuisine) ILIKE ?", pattern)
      @meals_by_ingredients = @meals_by_ingredients.where("LOWER(cuisine) ILIKE ?", pattern) if @meals_by_ingredients.any?
    end

    if params[:radius].present? && params[:latitude].present? && params[:longitude].present?
      coords = [params[:latitude].to_f, params[:longitude].to_f]
      radius = params[:radius].to_f

      @meals_by_name = @meals_by_name.near(coords, radius)
      @meals_by_ingredients = @meals_by_ingredients.near(coords, radius) if @meals_by_ingredients.any?
    end

    @displayed_meals = (@meals_by_name + @meals_by_ingredients).uniq

    @markers = @displayed_meals
      .select { |m| m.latitude.present? && m.longitude.present? }
      .map do |meal|
        {
          lat: meal.latitude,
          lng: meal.longitude,
          name: meal.name,
          description: meal.description.truncate(60),
          path: Rails.application.routes.url_helpers.meal_path(meal)
        }
      end

    puts "MARKERS DEBUG:"
    puts @markers.inspect
  end



  def show
    @meal = Meal.find(params[:id])
    authorize @meal
    @exchange = Exchange.new(meal_requested_id: @meal.id)
  end

  def new
    @meal = Meal.new
    authorize @meal
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
    @meal = Meal.find(params[:id])
    authorize @meal
  end


  def update
    @meal = current_user.meals.find(params[:id])
    authorize @meal
    if @meal.update(meal_params)
      redirect_to meals_path, notice: 'Meal was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def my_meals
    @meals = current_user.meals
    @pending_exchanges = Exchange.joins(:meal).where(meals: { user_id: current_user.id }, status: "pending")
    @my_offers = current_user.exchanges.includes(:meal)
  end
  def destroy
    set_meal
    if authorize @meal
      @meal.destroy
      redirect_to meals_path, notice: 'Meal was successfully deleted.'
    end
  end

  private

  def set_meal
    @meal = Meal.find(params[:id])
  end

  def meal_params
    permitted = params.require(:meal).permit(:name, :description, :ingredients, :category, :cuisine, :photo, :address)
    permitted[:cuisine] = permitted[:cuisine].to_s.titleize if permitted[:cuisine].present?
    permitted
  end


  def authorize_owner!(record)
    redirect_to root_path, alert: "Not authorized" unless record.user == current_user
  end
end
