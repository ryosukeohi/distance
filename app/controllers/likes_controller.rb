class LikesController < ApplicationController
  def create
    course = Course.find(params[:course_id])
    like = current_user.likes.new(course_id: course.id)
    like.save
    redirect_to course_path(course)
  end

  def destroy
    course = Course.find(params[:course_id])
    like = current_user.likes.find_by(course_id: course.id)
    like.destroy
    redirect_to course_path(course)
  end
end
