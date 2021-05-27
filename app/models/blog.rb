class Blog < ApplicationRecord
  validates :title, :body, :user_id, presence: true
  validates :category_id, presence: true, allow_blank: true

  belongs_to :user
  belongs_to :category
end
