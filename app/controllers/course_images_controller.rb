class CourseImagesController < ApplicationController
  def destroy
    @course_image = CourseImage.find(params[:id])
    @course_image.destroy
    redirect_to edit_course_path(@course_image.course.id)
  end
end
