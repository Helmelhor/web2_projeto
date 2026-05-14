class LikesController < ApplicationController
  def create
    # O item pode ser Quadra ou Comment
    item = params[:likeable_type].constantize.find(params[:likeable_id])
    Like.create(user: current_user, likeable: item)
    redirect_back fallback_location: root_path
  end

  def destroy
    item = params[:likeable_type].constantize.find(params[:likeable_id])
    like = Like.find_by(user: current_user, likeable: item)
    like.destroy if like
    redirect_back fallback_location: root_path
  end
end