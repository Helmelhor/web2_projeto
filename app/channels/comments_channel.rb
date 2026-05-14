class CommentsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "comments_channel"

    Rails.logger.info "CLIENTE CONECTADO AO COMMENTS_CHANNEL"
  end

  def unsubscribed
  end
end