class CourseCommentsController < ApplicationController
  def create
    course = Course.find(params[:course_id])
    comment = current_user.course_comments.new(course_comment_params)
    comment.course_id = course.id
    comment.save
    redirect_to course_path(course)
  end

  def destroy
    CourseComment.find_by(id: params[:id]).destroy
    redirect_to course_path(params[:course_id])
  end

  private

  def course_comment_params
    params.require(:course_comment).permit(:comment)
  end
end