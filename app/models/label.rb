# frozen_string_literal: true

# Labels
class Label < ApplicationRecord
  include FullTextSearchable

  validates_presence_of :title, :color

  has_many :note_labels
  has_many :notes, through: :note_labels

  define_full_text_search do |query, parent_scope|
    parent_scope.where(
      "to_tsvector('english_nostop', labels.title) @@ to_tsquery('english_nostop', :q)",
      q: query
    )
  end
end
