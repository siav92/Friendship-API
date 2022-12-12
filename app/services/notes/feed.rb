# frozen_string_literal: true

require 'constraint_query_generator'

module Notes
  # Note feed for user
  class Feed
    class InvalidParams < StandardError; end

    def initialize(user, params)
      @user = user
      @feed_params = FeedParams.new(params)
    end

    def search_and_filter # rubocop:disable Metrics/MethodLength
      raise InvalidParams unless feed_params.valid?

      scope = Note.full_text_search(feed_params.text_search_query)
      scope = scope_by_friends_notes(scope)

      case (queries = query_map(scope)).size
      when 0 then scope
      when 1 then queries.first
      else
        case feed_params.match_type
        when :any then Note.union(queries)
        when :all then scope.union_intersect(queries)
        end
      end
    end

    private

    attr_reader :user, :feed_params

    def query_map(scope)
      [
        scope_by_label_filters(scope),
        scope_by_friend_filters(scope)
      ].compact
    end

    def scope_by_friends_notes(scope)
      scope.joins('JOIN friendships ON notes.user_id = friendships.friend_id')
           .where(friendships: { user_id: user.id, status: :active })
    end

    def scope_by_label_filters(scope)
      filter_query(
        scope.left_joins(:labels),
        'labels.title',
        **feed_params.label_title_filters
      )
    end

    def scope_by_friend_filters(scope)
      filter_query(
        scope.joins('JOIN users AS friends on friends.id = friendships.friend_id'),
        'friends.email',
        **feed_params.friend_email_filters
      )
    end

    def filter_query(scope, key, **constraints)
      return if constraints.blank?

      ConstraintQueryGenerator.new(
        query: scope,
        key:,
        match_type: feed_params.match_type,
        **constraints
      ).call
    end
  end
end
