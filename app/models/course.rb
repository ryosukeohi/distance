class Course < ApplicationRecord
  belongs_to :user
  has_many :course_images, dependent: :destroy
  has_many :course_comments, dependent: :destroy

  accepts_attachments_for :course_images, attachment: :image

  geocoded_by :address
  before_validation :geocode

  def self.looks(word)
    @courses = Course.where(["title LIKE? OR description LIKE?", "%#{word}%", "%#{word}%"])
  end
end
