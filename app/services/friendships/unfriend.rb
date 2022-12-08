# frozen_string_literal: true

module Friendships
  # Destroy friendship records
  class Unfriend
    def initialize(friendship)
      @friendship = friendship
      @reverse_friendship = friendship.reverse_friendship
    end

    def run!
      Friendship.transaction do
        raise 'Friendships are not active!' unless friendship.active? && reverse_friendship.active?

        friendship.unfriended!
        reverse_friendship.unfriended!
      end

      true
    end

    private

    attr_reader :friendship, :reverse_friendship
  end
end
