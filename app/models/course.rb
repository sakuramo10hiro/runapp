class Course < ApplicationRecord
  
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy 
  has_one_attached :course_image

  geocoded_by :address
  after_validation :geocode

  def favorited?(user)
    favorites.where(user_id: user.id).exists?
  end
  validates :course_name, presence: true, length: { maximum: 30 }
  validates :distance, presence: true, numericality: true
  validates :course_description, length: { maximum: 200 }
  validates :public, inclusion: { in: [true, false] }
end
