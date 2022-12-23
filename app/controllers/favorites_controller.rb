class FavoritesController < ApplicationController
  def create
    @course_favorite = Favorite.new(user_id: current_user.id, course_id: params[:course_id])
    @course = Course.find(params[:course_id]) 
    @course_favorite.save
    redirect_to request.referer
  end

  def destroy
    @course_favorite = Favorite.find_by(user_id: current_user.id, course_id: params[:course_id])
    @course_favorite.destroy
    redirect_to request.referer
  end
end
