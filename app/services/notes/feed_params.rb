# frozen_string_literal: true

module Notes
  # Note feed for user
  class FeedParams
    include ActiveModel::Validations

    MATCH_TYPES = %i[any all].freeze

    validates :match_type, presence: true, inclusion: { in: MATCH_TYPES }

    def initialize(params)
      params = OpenStruct.new(params.to_h.deep_symbolize_keys)
      @text_search_query = params.query
      @match_type = params.match_type.to_sym || :all
      @friend_email_filters = params.filters[:friend_email] || {}
      @label_title_filters = params.filters[:label_title] || {}
    end

    attr_reader :text_search_query, :match_type, :friend_email_filters, :label_title_filters
  end
end
