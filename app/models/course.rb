class Course < ApplicationRecord
  belongs_to :user
  has_many :course_images, dependent: :destroy
  has_many :course_comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  accepts_attachments_for :course_images, attachment: :image

  geocoded_by :address
  before_validation :geocode

  validates :title, presence: true
  validates :description, presence: true
  validates :distance, presence: true
  validates :address, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true

  def self.looks(word)
    @courses = Course.where(["title LIKE? OR description LIKE?", "%#{word}%", "%#{word}%"])
  end

  def like_by?(user)
    likes.where(user_id: user.id).exists?
  end
end