class MessagesController < ApplicationController
  def index
    @exchange = Exchange.find(params[:exchange_id])
    @messages = @exchange.messages.includes(:user)
    @message = Message.new
  end
  def create
    @exchanges = Exchange.find(params[:exchange_id])
    @message = Message.new(message_params)
    @message.exchange = @exchanges
    @message.user = current_user
    if @message.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.append(:messages, partial: "messages/message", locals: { message: @message, user: current_user })
        end
        format.html { redirect_to exchange_path(@exchange) }
      end
    else
      render "exchanges/show", status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
