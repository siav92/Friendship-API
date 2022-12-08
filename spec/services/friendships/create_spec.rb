# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Friendships::Create do
  describe '#run!' do
    let(:user) { create(:user) }
    let(:friend) { create(:user) }
    let(:call) { Friendships::Create.new(user, friend).run! }

    it 'Creates friendship records' do
      expect { call }.to change(Friendship, :count).by(2)
    end

    context 'if friendship already exists' do
      it 'Creates friendship records' do
        create(:friendship, user: friend, friend: user)

        expect do
          call
        end.to raise_error(ActiveRecord::RecordInvalid, /Validation failed: User friendship already exists!/)

        expect(Friendship.count).to be 1
      end
    end
  end
end
