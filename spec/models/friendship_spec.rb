# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_presence_of(:friend) }

    context 'uniqueness' do
      let(:friendship) { create(:friendship) }
      it 'validates uniqueness of friendship records' do
        friendship = create(:friendship)
        duplicate = friendship.dup
        duplicate.validate
        expect(duplicate.errors.full_messages.first).to eq 'User friendship already exists!'
      end
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:friend) }
  end

  describe '#reverse_friendship' do
    it 'returns the inverse of the friendship' do
      friendship = create(:friendship)
      reverse_friendship = create(:friendship, user: friendship.friend, friend: friendship.user)

      expect(friendship.reverse_friendship).to eq reverse_friendship
    end
  end
end
