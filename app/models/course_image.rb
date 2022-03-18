class CourseImage < ApplicationRecord
  belongs_to :course
  attachment :image

  validates :course_id, presence: true
  validates :image_id, presence: true
end
