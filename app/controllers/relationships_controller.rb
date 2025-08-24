class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    user = User.find(params[:followed_id])
    current_user.following << user unless current_user.following.include?(user)
    redirect_to users_path, notice: "Now following #{user.username}"
  end

  def destroy
    relationship = Relationship.find(params[:id])
    user = relationship.followed
    relationship.destroy
    redirect_to users_path, notice: "Unfollowed #{user.username}"
  end
end
