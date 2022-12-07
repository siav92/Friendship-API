# frozen_string_literal: true

class Friendship < ApplicationRecord
  validates_presence_of :user, :friend
  validates_uniqueness_of :user, scope: :friend

  belongs_to :user
  belongs_to :friend, class_name: 'User', foreign_key: 'friend_id'

  STATUS = %i[created removed rejected trashed]

  def reverse_friendship
    Friendship.find_by(user: friend, friend: user)
  end
end
