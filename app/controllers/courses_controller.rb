class CoursesController < ApplicationController

  before_action :authenticate_user!, only: [:show, :create, :edit, :update, :destroy, :all_index]

  def index
    @courses = Course.all.where(user_id: current_user.id)
    @users = User.all
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    @course.user_id = current_user.id
    if @course.save
      redirect_to home_path, notice: '新しいコースが追加されました'
    else
      render "new"
    end
  end

  def edit
    @course = Course.find(params[:id])
  end

  def update
    @course = Course.find(params[:id])
    if @course.update(course_params)
      redirect_to home_path, notice: 'コース情報が更新されました'
    else
      render :new
    end
  end

  def destroy
    @course = Course.find(params[:id])
    @course.user_id = current_user.id
    @course.destroy!
    redirect_to home_path, notice: 'コースを削除しました'
  end

  def all_index
    @courses = Course.all.where(public: true)
    @users = User.all
  end

  private

  def course_params
    params.require(:course).permit(:course_name, :course_description, :public, :course_image, :distance, :road_type, :toilet, :undulation, :signal, :course_id)
  end

end
