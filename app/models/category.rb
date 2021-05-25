class Category < ApplicationRecord
  validates :title, :user_id presence: true

  has_many :blogs
  belongs_to :user
end
