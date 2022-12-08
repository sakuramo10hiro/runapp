class Course < ApplicationRecord

  def create

  end

  def show

  end
  def favorited?(user)
    favorites.where(user_id: user.id).exists?
  end

  belongs_to :user
  has_many :favorites, dependent: :destroy
end
