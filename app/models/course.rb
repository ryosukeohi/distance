class Course < ApplicationRecord
  belongs_to :user
  has_many :course_images, dependent: :destroy
end
