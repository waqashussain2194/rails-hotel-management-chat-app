module Smooch
  class SendMessage < Base
    attr_reader :message

    def initialize(message)
      @message = message
    end

    def call
      api.post_message(
        ENV.fetch('SMOOCH_APP_ID'),
        message.guest.external_id,
        body
      )
    rescue SmoochApi::ApiError => e
      logger.info "Exception when calling ConversationApi->post_message: #{e}"
    end

    private

    def api
      @api ||= SmoochApi::ConversationApi.new
    end

    def body
      @body ||= SmoochApi::MessagePost.new(
        role: 'appMaker',
        text: message.content,
        type: 'text'
      )
    end
  end
end
