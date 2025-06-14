class MealsController < ApplicationController
  before_action :set_meal, only: [:show, :edit, :update, :destroy, :remove_photo]
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
        exchange_status = if current_user
          Exchange.find_by(meal_offered: meal, requesting_user: current_user)&.status
        end

        {
          lat: meal.latitude,
          lng: meal.longitude,
          name: meal.name,
          description: meal.description.truncate(60),
          owner: "#{[meal.user.first_name, meal.user.last_name&.first&.upcase].compact.join(" ") + "."}",
          path: Rails.application.routes.url_helpers.meal_path(meal),
          status: exchange_status == "accepted" ? "accepted" : "blurred"
        }
      end
  end

  def show
    @meal = Meal.find(params[:id])
    @meal.photos.reload
    authorize @meal
  end

  def new
    @meal = Meal.new
    authorize @meal
  end

  def create
    @meal = Meal.new(meal_params)
    @meal.user = current_user
    authorize @meal

    if @meal.save
      redirect_to root_path, notice: 'Meal was successfully posted.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @meal
    @meal.photos.reload
  end

  def update
    @meal = current_user.meals.find(params[:id])
    authorize @meal

    if params[:meal][:remove_photo_ids].present?
      params[:meal][:remove_photo_ids].each do |photo_id|
        photo = @meal.photos.find_by(id: photo_id)
        photo&.purge
      end
    end

    if params[:meal][:photos].present?
      params[:meal][:photos].each do |photo|
        @meal.photos.attach(photo)
      end
    end

    if @meal.update(meal_params.except(:photos, :remove_photo_ids))
      redirect_to meal_path(@meal), notice: 'Meal updated successfully.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @meal
    @meal.destroy
    redirect_to meals_path, notice: 'Meal was successfully deleted.'
  end

  def remove_photo
    @meal = Meal.find(params[:id])
    photo = @meal.photos.find(params[:photo_id])
    photo.purge
    redirect_to edit_meal_path(@meal), notice: "Photo removed."
  end

  def my_meals
    @meals = current_user.meals
    @my_exchanges = Exchange.includes(:meal_offered, :requesting_user).where(meal_offered_id: @meals.pluck(:id)).distinct
  end

  private

  def set_meal
    @meal = Meal.find(params[:id])
  end

  def meal_params
    permitted = params.require(:meal).permit(
      :name, :description, :ingredients, :category, :cuisine, :address, :posted_on,
      photos: [], remove_photo_ids: [], photos_attachments_attributes: [:id, :_destroy]
    )
    permitted[:cuisine] = permitted[:cuisine].to_s.titleize if permitted[:cuisine].present?
    permitted
  end

  def authorize_owner!(record)
    redirect_to root_path, alert: "Not authorized" unless record.user == current_user
  end
end
