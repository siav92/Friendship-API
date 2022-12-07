# frozen_string_literal: true

module Friendships
  # Create friendship records
  class Create
    def initialize(user, friend)
      @user = user
      @friend = friend
    end

    def run!
      [].tap do |friendships|
        Friendship.transaction do
          friendships << Friendship.create!(user:, friend:)
          friendships << Friendship.create!(user: friend, friend: user)
        end
      end
    end

    private

    attr_reader :user, :friend
  end
end
