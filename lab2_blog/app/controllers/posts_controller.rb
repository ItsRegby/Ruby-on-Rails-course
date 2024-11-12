class PostsController < ApplicationController
  include PostsHelper
  before_action :authenticate_user!
  def index
    @posts = filter_and_sort_posts(Post.all, filter_params)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      PublishToTelegramService.new(@post).call
      BlogNotificationMailer.new_post_notification(@post).deliver_later
      redirect_to @post,  notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :category_id)
  end

  def filter_params
    params.permit(:category_id, :start_date, :end_date, :keyword, :min_comments, :max_comments, :sort)
  end
end
