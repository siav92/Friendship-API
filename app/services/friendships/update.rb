# frozen_string_literal: true

module Friendships
  # Update bidirectional friendship records
  class Update
    def initialize(friendship)
      @friendship = friendship
      @reverse_friendship = friendship.reverse_friendship
    end

    def run!
      Friendship.transaction do
        raise "Cannot perform '#{action}' action!" unless valid_action?

        friendship.send(action)
        reverse_friendship.send(action)
      end

      true
    end

    private

    attr_reader :friendship, :reverse_friendship

    def action
      raise 'Undefined method! Define in subclass.'
    end

    def valid_action?
      raise 'Undefined method! Define in subclass.'
    end
  end
end
