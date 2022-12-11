# frozen_string_literal: true

# Include PG full text search scope initializer
module FullTextSearchable
  extend ActiveSupport::Concern

  class_methods do
    def define_full_text_search
      raise 'Search query not given' unless block_given?

      scope(:full_text_search, lambda { |query|
        return if query.blank?

        formatted_query = format_query(query:)
        yield(formatted_query, self)
      })
    end

    def format_query(query:)
      query = drop_pg_reserved_chars(query)

      query.split.map do |word|
        "#{word}:*"
      end.join(' & ')
    end

    private

    def drop_pg_reserved_chars(query)
      # Drop characters reserved by tsquery to prevent PG syntax errors
      # https://www.postgresql.org/docs/11/datatype-textsearch.html#DATATYPE-TSQUERY
      query.gsub(/[:<>&|!()*\\]/, ' ')
    end
  end
end
