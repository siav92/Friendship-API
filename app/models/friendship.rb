# frozen_string_literal: true

# Friendship model between two users
class Friendship < ApplicationRecord
  validates_presence_of :user, :friend
  validates_uniqueness_of :user, scope: :friend, message: 'friendship already exists!'

  belongs_to :user
  belongs_to :friend, class_name: 'User', foreign_key: 'friend_id'

  STATUS = %i[created removed rejected trashed].freeze

  def reverse_friendship
    Friendship.find_by(user: friend, friend: user)
  end
end
