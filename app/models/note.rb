# frozen_string_literal: true

# Notes
class Note < ApplicationRecord
  include FullTextSearchable

  validates_presence_of :title, :content

  belongs_to :user
  has_many :note_labels
  has_many :labels, through: :note_labels

  define_full_text_search do |query, parent_scope|
    scope = parent_scope.left_outer_joins(:labels, :user)
    parent_scope.union(
      scope.where("to_tsvector('english_nostop', (notes.title) ||' ' || notes.content) @@
                   to_tsquery('english_nostop', :q)", q: query),
      scope.where("to_tsvector('english_nostop', labels.title) @@
                   to_tsquery('english_nostop', :q)", q: query),
      scope.where("to_tsvector('english_nostop', users.name) @@
                   to_tsquery('english_nostop', :q)", q: query)
    )
  end
end
