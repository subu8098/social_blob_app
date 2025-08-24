class User < ApplicationRecord
  has_secure_password
  has_many :posts, dependent: :destroy

  # Social relations
  has_many :active_relationships, class_name: "Relationship", foreign_key: :follower_id, dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :followed_id, dependent: :destroy

  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy


  validates :email, presence: true, uniqueness: true
  validates :username, presence: true
end
