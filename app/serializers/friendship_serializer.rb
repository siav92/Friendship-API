class FriendshipSerializer < ActiveModel::Serializer
  has_one :user
  has_one :friend
end
