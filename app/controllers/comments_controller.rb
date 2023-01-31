class CommentsController < ApplicationController
  def create
    course = Course.find(params[:course_id])
    @comment = current_user.comments.new(comment_params)
    @comment.course_id = course.id
    if @comment.save
      redirect_back(fallback_location: root_path)   
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
