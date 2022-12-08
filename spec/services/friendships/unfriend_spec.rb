# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Friendships::Unfriend do
  describe '#run!' do
    let(:user) { create(:user) }
    let(:friend) { create(:user) }
    let!(:friendship) { create(:friendship, user:, friend:) }
    let!(:reverse_friendship) { create(:friendship, user: friend, friend: user) }

    let(:call) { Friendships::Unfriend.new(friendship).run! }

    it 'Creates friendship records' do
      expect { call }.not_to change(Friendship, :count)
      expect(friendship.reload).to be_unfriended
      expect(reverse_friendship.reload).to be_unfriended
    end

    context 'if friendship is not active' do
      let!(:friendship) { create(:friendship, user:, friend:, status: :inactive) }
      let!(:reverse_friendship) { create(:friendship, user: friend, friend: user, status: :inactive) }

      it 'Creates friendship records' do
        expect do
          call
        end.to raise_error(RuntimeError, /Friendships are not active!/)
      end
    end
  end
end
