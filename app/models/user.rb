class User < ApplicationRecord
  has_secure_password
  validates :username, :email, :password, presence: true, :on => :create
  validates :username, :email, uniqueness: true

  has_many :blogs
  has_many :categories
end
