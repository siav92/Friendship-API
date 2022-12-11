# frozen_string_literal: true

module Friendships
  # Accept bidirectional friendship records
  class Accept < Update
    private

    def action
      :active!
    end

    def valid_action?
      friendship.inactive? &&
        reverse_friendship.inactive? &&
        friendship.created_at > reverse_friendship.created_at
    end
  end
end
