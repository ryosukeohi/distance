class CourseImage < ApplicationRecord
  belongs_to :course
  attachment :image
end
