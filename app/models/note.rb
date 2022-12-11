class Note < ApplicationRecord
  validates_presence_of :title, :content

  belongs_to :user
  has_many :note_labels
  has_many :labels, through: :note_labels
end
