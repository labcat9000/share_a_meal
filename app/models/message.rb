class Message < ApplicationRecord
  belongs_to :user
  belongs_to :exchange
  after_create_commit :broadcast_message

  def broadcast_message
    broadcast_append_to "exchanges_#{exchange.id}_messages", partial: "messages/message", locals: { message: self, user: user}, target: "messages"
  end

  private

  def messages_stream_target
    "messages_#{exchange_id}"
  end

  def alerts_stream_target
    "alerts_user_#{recipient_id}"
  end

  def recipient_id
    exchange.recipient_for(user).id
  end
end
