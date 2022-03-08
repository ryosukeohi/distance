class CoursesController < ApplicationController
  def index
    @courses = Course.all
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      redirect_to course_path(@course)
    else
      render 'course/new'
    end
  end

  private

  def course_params
    params.require(:course).permit(:title, :distance, :description, :latitude, :longitude, course_images_images: [])
  end
end
