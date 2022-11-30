class Friendship < ApplicationRecord
  validates_presence_of :user, :friend
  validates_uniqueness_of :user, scope: :friend

  belongs_to :user
  belongs_to :friend, class_name: 'User', foreign_key: 'friend_id'
end
