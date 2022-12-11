class Label < ApplicationRecord
  validates_presence_of :title, :color

  has_many :note_labels
  has_many :notes, through: :note_labels
end
