class CommentsController < ApplicationController
  def create
    course = Course.find(params[:course_id])
    @comment = current_user.comments.new(comment_params)
    @comment.course_id = course.id
    if @comment.save
      redirect_back(fallback_location: root_path)
    else
      @error_comment = @comment
      @course = Course.find(params[:course_id])
      @comment = current_user.comments.new
      @road_type = { 0 => 'ロード', 1 => 'トレイル', 2 => 'トラック' }
      @route = { 0 => '周回', 1 => '往復', 2 => '片道' }
      @toilet = { 0 => '少ない', 1 => '普通', 2 => '多い' }
      @undulation = { 0 => '少ない', 1 => '普通', 2 => '多い' }
      @signal = { 0 => '少ない', 1 => '普通', 2 => '多い' }
      render 'courses/show'
    end
  end

  def destroy
    Comment.find_by(id: params[:id], course_id: params[:course_id]).destroy
    redirect_to course_path(params[:course_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:comment_content, :course_id)
  end
end
