class CoursesController < ApplicationController
  def index
    @courses = Course.all
  end

  def mycourse
    @courses = current_user.courses
  end

  def show
    @course = Course.find(params[:id])
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    @course.user_id = current_user.id
    if @course.save
      redirect_to course_path(@course)
    else
      redirect_to new_course_path
    end
  end

  private

  def course_params
    params.require(:course).permit(:title, :address, :distance, :description, :latitude, :longitude, course_images_images: [])
  end
end
