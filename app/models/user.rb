# frozen_string_literal: true

# Users of the app
class User < ApplicationRecord
  has_secure_password
  validates_presence_of :email, :name
  validates_uniqueness_of :email

  has_many :friendships, -> { active }
  has_many :reverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id', dependent: :destroy
  has_many :friends, through: :friendships, source: :friend
  has_many :notes
end
