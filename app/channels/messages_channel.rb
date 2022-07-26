# app/channels/messages_channel.rb
class MessagesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "messages:#{current_user.hotel_id}"
  end
end
