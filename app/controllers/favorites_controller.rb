class FavoritesController < ApplicationController
  def create
    @course_favorite = Favorite.new(user_id: current_user.id, course_id: params[:course_id])
    @course = Course.find(params[:course_id])
    if @course_favorite.save
      flash[:success] = 'コースにいいねしました。'
      redirect_to request.referer
    end
  end

  def destroy
    @course_favorite = Favorite.find_by(user_id: current_user.id, course_id: params[:course_id])
    if @course_favorite.destroy
      flash[:success] = 'コースのいいねを取り消しました。'
      redirect_to request.referer
    end
  end
end
