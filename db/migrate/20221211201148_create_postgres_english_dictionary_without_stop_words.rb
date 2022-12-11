# frozen_string_literal: true

# Create a copy of postgres English dictionary and configuration without stop words
# as we wanna be able to index and search stop words in some cases.
#
# For more info visit:
#   https://www.postgresql.org/docs/current/textsearch-configuration.html
# List of stop words by default:
#   https://github.com/postgres/postgres/blob/master/src/backend/snowball/stopwords/english.stop
#
class CreatePostgresEnglishDictionaryWithoutStopWords < ActiveRecord::Migration[7.0]
  def up
    # Create new dictionary with no stopwords
    execute 'CREATE TEXT SEARCH DICTIONARY english_stem_nostop (Template = snowball, Language = english);'

    # Create new text search configuration and based on default english configuration
    execute 'CREATE TEXT SEARCH CONFIGURATION public.english_nostop ( COPY = pg_catalog.english );'

    # Set up the mappings for words in configuration
    execute '
      ALTER TEXT SEARCH CONFIGURATION public.english_nostop
        ALTER MAPPING FOR asciiword, asciihword, hword_asciipart, hword, hword_part, word
        WITH english_stem_nostop;
    '
  end

  def down
    # Drop dictionary with its dependants
    execute 'DROP TEXT SEARCH DICTIONARY english_stem_nostop CASCADE;'
  end
end
