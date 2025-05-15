class UsersController < ApplicationController
  def index
    if params[:view] == "offers"
      @exchanges = current_user.exchanges.order(created_at: :desc)

      # Mark all accepted/declined bookings as seen
      @exchanges.where(status: ["accepted", "declined"], seen_status: false).update_all(seen_status: true)
    end
  end

  def show
  end

  def offers
    @exchanges = current_user.exchanges
    @exchanges.where(status: ["accepted", "declined"], seen_status: false).update_all(seen_status: true)
  end
end
