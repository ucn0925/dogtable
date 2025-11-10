class Post < ApplicationRecord
  belongs_to :user
  belongs_to :shop

  has_many_attached :images

  enum dog_size: { small: 0, medium: 1, large: 2 } 

  validates :content, presence: true
end
