class CoursesController < ApplicationController

  before_action :authenticate_user!, only: [:show, :create, :edit, :update, :destroy, :all_index]

  def index
    @courses = Course.all.where(user_id: current_user.id)
    @users = User.all
    @road_type = {0=> 'ロード', 1=> 'トレイル', 2=> 'トラック'}
    @route = {0=> '周回', 1=> '往復', 2=> '片道'}
    @toilet = {0=> '少ない', 1=> '普通', 2=> '多い'}
    @undulation = {0=> '少ない', 1=> '普通', 2=> '多い'}
    @signal = {0=> '少ない', 1=> '普通', 2=> '多い'}
  end

  def index_user
    @courses = Course.where(user_id:params[:id])
    @user = User.find(params[:id])
    @road_type = {0=> 'ロード', 1=> 'トレイル', 2=> 'トラック'}
    @route = {0=> '周回', 1=> '往復', 2=> '片道'}
    @toilet = {0=> '少ない', 1=> '普通', 2=> '多い'}
    @undulation = {0=> '少ない', 1=> '普通', 2=> '多い'}
    @signal = {0=> '少ない', 1=> '普通', 2=> '多い'}
  end

  def show
    @course = Course.find(params[:id])
    @comments = @course.comments  
    @comment = current_user.comments.new 
    @road_type = {0=> 'ロード', 1=> 'トレイル', 2=> 'トラック'}
    @route = {0=> '周回', 1=> '往復', 2=> '片道'}
    @toilet = {0=> '少ない', 1=> '普通', 2=> '多い'}
    @undulation = {0=> '少ない', 1=> '普通', 2=> '多い'}
    @signal = {0=> '少ない', 1=> '普通', 2=> '多い'}
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    @course.user_id = current_user.id
    if @course.save
      redirect_to mypage_path, notice: '新しいコースが追加されました。'
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
      redirect_to mypage_path, notice: 'コース情報が更新されました。'
    else
      render :new
    end
  end

  def destroy
    @course = Course.find(params[:id])
    @course.user_id = current_user.id
    @course.destroy!
    redirect_to mypage_path, notice: 'コースを削除しました。'
  end

  def all_index
    @courses = Course.all.where(public: true)
    @users = User.all
    @road_type = {0=> 'ロード', 1=> 'トレイル', 2=> 'トラック'}
    @route = {0=> '周回', 1=> '往復', 2=> '片道'}
    @toilet = {0=> '少ない', 1=> '普通', 2=> '多い'}
    @undulation = {0=> '少ない', 1=> '普通', 2=> '多い'}
    @signal = {0=> '少ない', 1=> '普通', 2=> '多い'}
  end

  private

  def course_params
    params.require(:course).permit(:course_name, :course_description, :public, :course_image, :distance, :road_type, :toilet, :undulation, :signal, :address, :latitude, :longitude, :course_content, :route)
  end

end
