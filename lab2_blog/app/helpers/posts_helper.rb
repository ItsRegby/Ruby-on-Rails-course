module PostsHelper
  def filter_and_sort_posts(posts, params)
    posts = filter_by_category(posts, params[:category_id])
    posts = filter_by_date_range(posts, params[:start_date], params[:end_date])
    posts = filter_by_keyword(posts, params[:keyword])
    posts = filter_by_comment_count(posts, params[:min_comments], params[:max_comments])
    sort_posts(posts, params[:sort])
  end

  private

  def filter_by_category(posts, category_id)
    return posts unless category_id.present?
    posts.where(category_id: category_id)
  end

  def filter_by_date_range(posts, start_date, end_date)
    posts = posts.where("created_at >= ?", start_date) if start_date.present?
    posts = posts.where("created_at <= ?", end_date) if end_date.present?
    posts
  end

  def filter_by_keyword(posts, keyword)
    return posts unless keyword.present?
    posts.where("title ILIKE :keyword OR body ILIKE :keyword", keyword: "%#{keyword}%")
  end

  def filter_by_comment_count(posts, min_comments, max_comments)
    posts = posts.joins(:comments).group(:id).having("COUNT(comments.id) >= ?", min_comments) if min_comments.present?
    posts = posts.joins(:comments).group(:id).having("COUNT(comments.id) <= ?", max_comments) if max_comments.present?
    posts
  end

  def sort_posts(posts, sort_param)
    case sort_param
    when 'newest'
      posts.order(created_at: :desc)
    when 'oldest'
      posts.order(created_at: :asc)
    when 'most_comments'
      posts.left_joins(:comments).group(:id).order('COUNT(comments.id) DESC')
    when 'least_comments'
      posts.left_joins(:comments).group(:id).order('COUNT(comments.id) ASC')
    when 'title_asc'
      posts.order(title: :asc)
    when 'title_desc'
      posts.order(title: :desc)
    else
      posts
    end
  end
end