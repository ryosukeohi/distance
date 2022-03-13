class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :courses, dependent: :destroy
  has_many :records, dependent: :destroy
  has_many :course_comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  attachment :profile_image

  def self.looks(word)
    @users = User.where(["name LIKE? OR introduction LIKE?", "%#{word}%", "%#{word}%"])
  end
end
