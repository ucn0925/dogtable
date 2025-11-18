class Post < ApplicationRecord
  belongs_to :user
  belongs_to :shop

  has_many_attached :images
  has_many :post_favorites, dependent: :destroy
  has_many :favorited_users, through: :post_favorites, source: :user

  enum dog_size: { small: 0, medium: 1, large: 2 } 

  validates :content, presence: true

  def favorited_by?(user)
    post_favorites.exists?(user_id: user.id)
  end
end
