# frozen_string_literal: true

# Add Gin indexes on issue metadata for full text search
# https://www.postgresql.org/docs/11/textsearch-tables.html
# Note that only a query reference that uses the same version of to_tsvector with
# the same configuration name will use the index.
#
class AddFullTextSearchGinIndexes < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def up
    # Coalesce should be used to prevent a single NULL attribute from causing a NULL result for the whole document.
    add_index :notes, "to_tsvector('english_nostop', (title || ' ' || content))",
              using: 'gin',
              algorithm: :concurrently,
              name: :fts_index_notes_on_title_and_content
    add_index :users, "to_tsvector('english_nostop', email)",
              using: 'gin',
              algorithm: :concurrently,
              name: :fts_index_users_on_email
    add_index :labels, "to_tsvector('english_nostop', title)",
              using: 'gin',
              algorithm: :concurrently,
              name: :fts_index_labels_on_title
  end

  def down
    remove_index :notes, name: :fts_index_notes_on_title_and_content, algorithm: :concurrently
    remove_index :users, name: :fts_index_users_on_email, algorithm: :concurrently
    remove_index :labels, name: :fts_index_labels_on_title, algorithm: :concurrently
  end
end
