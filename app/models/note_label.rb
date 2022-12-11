class NoteLabel < ApplicationRecord
  validates_uniqueness_of :note, scope: :label

  belongs_to :note
  belongs_to :label
end
