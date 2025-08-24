class PostsController < ApplicationController
  before_action :authenticate_user!

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path, notice: "Post created successfully!"
    else
      render :new, alert: "Could not save post."
    end
  end

  def index
    # Show public posts and private posts from users the current user follows
    followed_ids = current_user.following.pluck(:id)
    @posts = Post.where("visibility = ? OR (visibility = ? AND user_id IN (?))", "public", "private", followed_ids)
            .order(created_at: :desc)
  end


  private

  def post_params
    params.require(:post).permit(:content, :visibility)
  end

end
