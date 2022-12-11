class Note < ApplicationRecord
  validates_presence_of :user, :title, :content

  belongs_to :user
end
