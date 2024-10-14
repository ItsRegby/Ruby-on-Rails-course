class BlogNotificationMailer < ApplicationMailer
  default from: 'info@info.com'

  def new_post_notification(post)
    @post = post
    mail(to: 'subscriber@example.com', subject: 'New Blog Post Published')
  end

  def new_comment_notification(comment)
    @comment = comment
    @post = comment.post
    mail(to: 'subscriber@example.com', subject: 'New Comment on Your Post')
  end
end