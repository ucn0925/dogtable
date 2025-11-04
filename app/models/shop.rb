class Shop < ApplicationRecord
  belongs_to :user
  belongs_to :genre, optional: true
  belongs_to :block, optional: true
  belongs_to :city, optional: true

  has_many :shop_favorites, dependent: :destroy
  has_many :favorited_users, through: :shop_favorites, source: :user
  has_many :comments, dependent: :destroy

  has_many_attached :images
  
  validates :name, presence: true
  validates :address, presence: true
  validates :genre_id, presence: true
  validates :block_id, presence: true
end
