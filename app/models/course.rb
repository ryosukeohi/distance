class Course < ApplicationRecord
  belongs_to :user
  has_many :course_images, dependent: :destroy
  has_many :course_comments, dependent: :destroy

  accepts_attachments_for :course_images, attachment: :image

  geocoded_by :address
  before_validation :geocode

  def self.search(keyword)
    where(["title like? OR description like?", "%#{keyword}%", "%#{keyword}%"])
  end
end
