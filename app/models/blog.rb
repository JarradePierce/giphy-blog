class Blog < ApplicationRecord
  validates :title, :body, :user_id, :points, presence: true
  validates :category_id, presence: true, allow_blank: true
  validates :completed, presence: true, allow_blank: true

  belongs_to :user
  belongs_to :category

end
