class ExchangesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_meal, only: [:new, :create]
  before_action :set_exchange, only: [:edit_rating, :update_rating]

  def new
    @exchange = Exchange.new
  end

  # no need for an exchanges show page
  # def show
  #   @exchange = Exchange.new(meal_requested_id: @meal.id)
  # end

  def accept
    @exchange = Exchange.find(params[:id])
    authorize @exchange.meal, :update?  # meal owner only

    @exchange.update(accepted: true, seen: true)
    redirect_to meal_path(@exchange.meal), notice: "Exchange accepted!"
  end

  def decline
    @exchange = Exchange.find(params[:id])
    authorize @exchange.meal, :update?  # meal owner only

    @exchange.destroy
    redirect_to meal_path(@exchange.meal), notice: "Exchange declined."
  end

  def update
    @exchanges =Exchange.find(params[:id])
    if @exchange.meal.user == current_user
      if @exchange.update(exchange_params)
        if @exchange.saved_change_to_status? && %w[accepted declined].include?(@exchange.status)
          @exchange.update(seen_status: false)
          flash[:notice] = "exchange status updated to #{@exchange.status.capitalize}"
        end
        redirect_to_user_meals_path
      else
        flash[:alert] = "failed to update exchange"
        render :edit
      end
    else
      flash[:alert] = "You're not authorized to edit this exchange"
      redirect_to root_path
    end
  end

  def create
    @exchange = Exchange.new(exchange_params)
    @exchange.meal_requested = @meal
    @exchange.requesting_user_id = current_user.id

    if @exchange.save
      redirect_to meal_path(@exchange.meal_requested), notice: "Share requested!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @exchanges = Exchange.find(params[:id])
    meal = @exchange.meal

    if @exchange.user == current_user
      @exchange.destroy
      redirect_to meal_path(meal), notice: "Exchange was successfully deleted!"
    else
      redirect_to root_path, alert: "Unauthorized."
    end
  end

  def my_exchanges
    @exchanges = Exchange.where(user: current_user)
  end

  def exchanges_dashboard
    @current_exchanges = Exchange.where(requesting_user_id: current_user.id, status: ["Accepted", "Pending"])
    @past_exchanges = Exchange.where(requesting_user_id: current_user.id, status: ["Declined", "Complete"])
    # @exchange_requests = Exchange.where(meal_offered.user = current_user.id)
    @exchange_requests = Exchange.joins(:meal_offered).where(meals: { user_id: current_user.id })
    @my_meals = Meal.where(user_id: current_user.id)
  end

  def exchange_requests
  end

  def edit_rating
    @rating_user = params[:user] # expecting 'offering' or 'requesting'
  end

  def update_rating
    @rating_user = params[:user] # "offering" or "requesting"
    rating_params = params.require(:exchange).permit(:rating, :comment)

    if %w[offering requesting].include?(@rating_user)
      @exchange.update(
        "#{@rating_user}_user_rating": rating_params[:rating],
        "#{@rating_user}_user_comment": rating_params[:comment]
      )
      redirect_to @exchange, notice: "Thank you for your rating!"
    else
      redirect_to @exchange, alert: "Invalid user type for rating"
    end
  end

  private

  def set_meal
    @meal = Meal.find(params[:meal_id])
  end


  def exchange_params
    params.require(:exchange).permit(:meal_offered_id, :meal_requested_id)
  end
end
