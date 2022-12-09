class Course < ApplicationRecord

  def favorited?(user)
    favorites.where(user_id: user.id).exists?
  end

  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy 
end
