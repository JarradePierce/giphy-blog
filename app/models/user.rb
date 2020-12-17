class User < ApplicationRecord
  has_secure_password
  validates_exist_email_of :email
  validates :username, :email, :password, presence: true, :on => :create
  validates :username, :email, uniqueness: true

  has_many :blogs
end
