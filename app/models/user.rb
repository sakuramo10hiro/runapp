class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  validates :introduction, presence: false, length: { maximum: 100 } 
  validates :name, presence: true
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :courses, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy 
  has_one_attached :image
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :user

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.name = "ゲスト" 
      user.password = SecureRandom.urlsafe_base64
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
    end
  end
  
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end
end
