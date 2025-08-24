class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    post = Post.find(params[:post_id])
    # Only allow to like if visible (public or followed private)
    if post.visibility == 'public' || (post.visibility == 'private' && current_user.following.include?(post.user)) || post.user == current_user
      current_user.likes.create(post: post)
      redirect_to posts_path, notice: 'Liked the post!'
    else
      redirect_to posts_path, alert: 'You are not allowed to like this post.'
    end
  end

  def destroy
    like = current_user.likes.find(params[:id])
    like.destroy if like
    redirect_to posts_path, notice: 'Unliked the post!'
  end

end
