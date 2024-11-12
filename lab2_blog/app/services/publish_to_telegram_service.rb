class PublishToTelegramService
  def initialize(post)
    @post = post
  end

  def call
    message = <<~MESSAGE
      📝 *New Blog Post Published* 📢

      *Title*: #{@post.title}
      
      *Excerpt*: #{@post.body.to_plain_text.truncate(200)}

      👉 Read more on our blog: #{post_url}
    MESSAGE

    begin
      TELEGRAM_BOT_CLIENT.api.send_message(
        chat_id: ENV['TELEGRAM_CHANNEL_ID'],
        text: message,
        parse_mode: 'Markdown'
      )
    rescue Telegram::Bot::Exceptions::ResponseError => e
      Rails.logger.error("Failed to send message to Telegram: #{e.message}")
    end
  end

  private

  def post_url
    Rails.application.routes.url_helpers.post_url(@post, host: 'localhost', port: 3000)
  end
end
