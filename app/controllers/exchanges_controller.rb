class ExchangesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_meal, only: [:new, :create]
  before_action :set_exchange, only: [:edit_rating, :update_rating]

  def new
    @exchange = Exchange.new
  end

  def show
    @exchange = Exchange.find(params[:id])
    @messages = @exchange.messages.includes(:user)
  end

  def accept
    @exchange = Exchange.find(params[:id])
    authorize @exchange  # meal owner only
    @exchange.update(accepted: true, seen: true, status: "Accepted", meal_requested_id: params[:meal_id])
    redirect_to user_meals_path(section: "exchanges"), notice: "Exchange accepted!"
  end

  def decline
    @exchange = Exchange.find(params[:id])
    authorize @exchange  # meal owner only
    @exchange.update(accepted: false, status: "Declined")
    redirect_to user_meals_path(section: "exchanges"), notice: "Exchange declined."
  end

  def update
    @exchanges = Exchange.find(params[:id])
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
    @meal = Meal.find(params[:meal_id])
    @exchange = Exchange.new
    @exchange.meal_offered = @meal
    @exchange.requesting_user = current_user
    if @exchange.save!
      redirect_to user_exchanges_path(section: "current"), notice: "Share requested!"
    else
      redirect_to meal_path(@meal), notice: "Share request unsuccessful."
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
    @current_exchanges = Exchange.where(requesting_user_id: current_user.id, status: ["Accepted", "Pending"])
    @past_exchanges = Exchange.where(requesting_user_id: current_user.id, status: ["Declined", "Completed"])
  end

  def exchanges_dashboard
    @current_exchanges = Exchange.where(requesting_user_id: current_user.id, status: ["Accepted", "Pending"])
    @past_exchanges = Exchange.where(requesting_user_id: current_user.id, status: ["Declined", "Completed"])
    @exchange_requests = Exchange
      .includes(:meal_offered, :requesting_user)
      .where("meal_offered_id IN (:meal_ids)",
            meal_ids: current_user.meals.pluck(:id))
    @my_meals = Meal.where(user_id: current_user.id)
    @messages = Message.includes(:user).order(created_at: :asc)
    @latest_messages = Message
    .includes(:exchange, :user)
    .where(exchange_id: Exchange.where(
      status: "Accepted"
    ).where(
      "requesting_user_id = :id OR meal_offered_id IN (:meal_ids)",
      id: current_user.id,
      meal_ids: current_user.meals.ids
    ))
    .order(created_at: :desc)
    .group_by(&:exchange)
    .transform_values(&:first)
      # or scoped by user or exchange
  end

  # def exchange_requests
  # end

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

  def recipient_for(sender)
    meal_offered.user == sender ? meal_requested.user : meal_offered.user
  end


  private

  def set_meal
    @meal = Meal.find(params[:meal_id])
  end


  def exchange_params
    params.require(:exchange).permit(:meal_offered_id, :meal_requested_id, :date)
  end
end
