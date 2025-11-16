class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  has_many :shops, dependent: :destroy
  has_many :shop_favorites, dependent: :destroy
  has_many :favorite_shops, through: :shop_favorites, source: :shop
  has_many :posts, dependent: :destroy
  has_one :dog, dependent: :destroy
  has_one_attached :profile_image

  accepts_nested_attributes_for :dog, 
    reject_if: proc { |a| a.values.all?(&:blank?) },
    update_only: true

  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :active_relationships, source: :followed

  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower

  def follow(user)
    followings << user unless self == user
  end

  def unfollow(user)
    relationship = active_relationships.find_by(followed_id: user.id)
    relationship&.destroy
  end

  def following?(user)
    active_relationships.exists?(followed_id: user.id)
  end


  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
