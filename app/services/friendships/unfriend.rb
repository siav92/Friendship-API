# frozen_string_literal: true

module Friendships
  # Destroy bidirectional friendship records
  class Unfriend < Update
    private

    def action
      :unfriended!
    end

    def valid_action?
      friendship.active? && reverse_friendship.active?
    end
  end
end
