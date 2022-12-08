class FavoritesController < ApplicationController
  def create
    @course_favorite = Favorite.new(user_id: current_user.id, course_id: params[:course_id])
    @course_favorite.save
    redirect_to course_path(params[:course_id]) 
  end

  def destroy
    @course_favorite = Favorite.find_by(user_id: current_user.id, course_id: params[:course_id])
    @course_favorite.destroy
    redirect_to course_path(params[:course_id]) 
  end
end
