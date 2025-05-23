class ExchangesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_meal, only: [:new, :create, :show]

  def new
    @exchanges = Exchange.new
  end

  def show
    @exchange = Exchange.new(meal_requested_id: @meal.id)
  end

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
    @exchange.meal = @meal
    @exchange.user = current_user

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
  end

  def exchange_requests
  end

  private

  def set_meal
    @meal = Meal.find(params[:meal_id])
  end

  def exchange_params
    params.require(:exchange).permit(:meal_offered_id, :meal_requested_id)
  end
end
