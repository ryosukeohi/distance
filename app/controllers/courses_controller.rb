class CoursesController < ApplicationController
  def index
    @courses = Course.all
  end

  def mycourse
    @courses = current_user.courses
  end

  def show
    @course = Course.find(params[:id])
    @course_comment = CourseComment.new
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

  def edit
    @course = Course.find(params[:id])
  end

  def update
    @course = Course.find(params[:id])
    @course.update(course_params)
    redirect_to course_path(@course)
  end

  def destroy
    @course = Course.find(params[:id])
    @course.destroy
    redirect_to user_path(current_user.id)
  end

  private

  def course_params
    params.require(:course).permit(:title, :address, :distance, :description, :latitude, :longitude, course_images_images: [])
  end
end
