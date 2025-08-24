class Post < ApplicationRecord
  belongs_to :user
  validates :content, presence: true
  validates :visibility, inclusion: { in: %w(public private) }
end
