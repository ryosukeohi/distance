class Record < ApplicationRecord
  belongs_to :user
  has_many :record_images, dependent: :destroy

  validates :distance, presence: true

  accepts_attachments_for :record_images, attachment: :image
end
