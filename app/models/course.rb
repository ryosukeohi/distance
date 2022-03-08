class Course < ApplicationRecord
  belongs_to :user
  has_many :course_images, dependent: :destroy
  geocoded_by :address
  after_validation :geodode
end
