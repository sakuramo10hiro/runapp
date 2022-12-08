class CoursesController < ApplicationController

  def show

  end

  def new

  end

  def create

  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

  def course_params
    params.require(:list).permit(:course_name, :course_description, :public, :course_image, :distance, :road_type, :toilet, :undulation, :signal, :course_id)
  end

end
