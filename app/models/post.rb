class Post < ApplicationRecord
  belongs_to :user
  belongs_to :group

  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post

  validates :content, presence: true
end
