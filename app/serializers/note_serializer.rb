class NoteSerializer < ActiveModel::Serializer
  attributes :id, :title, :content
  has_one :user
  has_many :labels
end
