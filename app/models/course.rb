class Course < ApplicationRecord
  
  geocoded_by :address # addressカラムを基準に緯度経度を算出する。
  after_validation :geocode # 住所変更時に緯度経度も変更する。

  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy 
  has_one_attached :course_image

  def favorited?(user)
    favorites.where(user_id: user.id).exists?
  end
  validates :course_name, presence: true, length: { maximum: 30 }
  validates :distance, presence: true, numericality: true
  validates :course_description, length: { maximum: 100 }
  validates :public, inclusion: { in: [true, false] }
end
