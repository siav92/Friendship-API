# frozen_string_literal: true

class FriendshipSerializer < ActiveModel::Serializer
  attributes :status

  has_one :user
  has_one :friend
end
