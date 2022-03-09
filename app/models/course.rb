class Course < ApplicationRecord
  belongs_to :user
  has_many :course_images, dependent: :destroy

  accepts_attachments_for :course_images, attachment: :image

  geocoded_by :address
  before_validation :geocode
end
