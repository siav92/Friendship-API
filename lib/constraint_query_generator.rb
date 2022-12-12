# frozen_string_literal: true

# Constraint query generator for feed filtering of notes
class ConstraintQueryGenerator
  def initialize(query:, included:, excluded:, match_type:, key: :id)
    @query = query
    @included = included
    @excluded = excluded
    @match_type = match_type
    @key = key
  end

  def call
    (field_constraint_query || query).distinct
  end

  private

  attr_reader :query, :included, :excluded, :match_type, :key

  # Different combinations of "in" and "nin" filters
  def field_constraint_query
    if included.present? && excluded.present?
      composition_query
    elsif included.present?
      inclusion_query
    elsif excluded.present?
      query.klass.union_except(query, exclusion_query)
    end
  end

  def composition_query
    case match_type
    when :any
      query.klass.union(
        inclusion_query,
        query.klass.union_except(query, exclusion_query)
      )
    when :all
      query.klass.union_except(inclusion_query, exclusion_query)
    end
  end

  def inclusion_query
    case match_type
    when :any then query.where(key => included)
    when :all then chain_union_intersect(included)
    end
  end

  def exclusion_query
    case match_type
    when :any then chain_union_intersect(excluded)
    when :all then query.where(key => excluded)
    end
  end

  def chain_union_intersect(array)
    query_map = array.map do |value|
      query.where(key => value)
    end

    query_map.one? ? query_map.first : query.union_intersect(query_map)
  end
end
