class ExchangesController < ApplicationController
  before_action :set_meal, only: [:new, :create]

  def def new
    @exchanges = Exchange.new
  end

  def accept
    @exchanges = Exchange.find(params[:id])
    exchanges.update(status: "accepted")
    redirect_back fallbake_location: user_meals_path, notice: "Exchange accepted"
  end

  def decline
    @exchanges = Exchange.find(params[:id])
    exchanges.update(status: "declined")
    redirect_back fallback_location: user_meals_path, alert: "Exchange declined"
  end

  def update
    @exchanges =Exchange.find(params[:id])
    if @exchange.meal.user == current_user
      if @exchange.update(exchange_params)
        if @exchange.saved_change_to_status? && %w[accepted declined].include?(@exchange.status)
          @exchange.update(seen_status: false)
          flash[:notice] = "exchange status updated to #{@booking.status.capitalize}"
        end
        redirect_to_user_meals_path
      else
        flash[:alert] = "failed to update exchange"
        render :edit
      end
    else
      flash[:alert] = "You're not authorized to change this exchange"
      redirect_to root_path
    end
  end

  def my_exchanges
    @exchanges = current_user.exchanges.includes(:meal)
  end
  def create
    @exchange = Exchange.new(exchange_params)
    @exchange.meal_requested = Meal.find(params[:exchange][:meal_requested_id])
    @exchange.meal_offered = Meal.find(params[:exchange][:meal_offered_id])

    if @exchange.save
      redirect_to meal_path(@exchange.meal_requested), notice: "Exchange proposed!"
    else
      redirect_to meal_path(@exchange.meal_requested), alert: "Something went wrong."
    end
  end

  if @exchange.save
    redirect_to meal_path(@meal), notice: 'Exchange was successfully created.'
  else
    @exchanges = Exchange.new
    render :new, status: :unprocessable_entity
  end
end

  def destroy
    @exchanges = Exchange.find(params[:id])
    meal = @exchange.meal

    if @exchange.user == current_user
      @exchange.destroy
      redirect_to meal_path(meal), notice: "exchange was successfully deleted!"
    else
      redirect_to root_path, alert: "Unauthorized."
    end
  end

  private

  def set_meal
    @meal = Meal.find(params[:meal_id])
  end

  def exchange_params
    params_required(:exchange).permit(:status)
  end
end
