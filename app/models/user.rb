class User < ApplicationRecord
  has_secure_password
  validates :username, :email, :password, presence: true, uniqueness: true

  has_many :blogs
end