class ExchangesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_meal, only: [:new, :create, :show]


  def new
    @exchange = Exchange.new
  end
  def new
    @exchange = Exchange.new
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

  def create
    @exchange = Exchange.new(exchange_params)
    @exchange.meal = @meal
    @exchange.user = current_user

    if @exchange.save
      redirect_to meal_path(@meal), notice: "Exchange request sent!"
    else
      render :new, status: :unprocessable_entity
    end
  end


  def my_exchanges
    @exchanges = Exchange.where(user: current_user)
  end

  private

  def set_meal
    @meal = Meal.find(params[:meal_id])
  end

  def exchange_params
    params.require(:exchange).permit(:your_meal_id)
  end
end
