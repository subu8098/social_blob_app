class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    post = Post.find(params[:post_id])
    # Only allow comment if user can view post (like likes logic)
    if post.visibility == 'public' || (post.visibility == 'private' && current_user.following.include?(post.user)) || post.user == current_user
      comment = current_user.comments.create(post: post, content: params[:content])
      if comment.persisted?
        redirect_to posts_path, notice: 'Comment added!'
      else
        redirect_to posts_path, alert: 'Comment cannot be blank!'
      end
    else
      redirect_to posts_path, alert: 'You are not allowed to comment on this post.'
    end
  end

  def destroy
    comment = current_user.comments.find(params[:id])
    comment.destroy if comment
    redirect_to posts_path, notice: 'Comment deleted!'
  end
end
