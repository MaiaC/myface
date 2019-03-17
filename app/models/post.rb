class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, as: :likeable
  has_many :comments, as: :commentable

  default_scope -> { order(created_at: :desc ) }
end
