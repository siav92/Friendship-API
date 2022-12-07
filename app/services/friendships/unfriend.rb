module Friendships
  class Unfriend
    def initialize(friendship)
      @friendship = friendship
    end

    def run!
      Friendship.transaction do
        friendship.destroy!
        friendship.reverse_friendship.destroy!
      end

      true
    end

    private

    attr_reader :friendship
  end
end