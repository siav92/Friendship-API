class User < ApplicationRecord
  has_secure_password
  validates_presence_of :email, :name
  validates_uniqueness_of :email

  has_many :friendships
  has_many :friends, through: :friendships, source: :friend
end
