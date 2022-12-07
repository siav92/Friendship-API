# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to have_secure_password }
    it do
      create(:user)
      should validate_uniqueness_of(:email)
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:friendships) }
    it { is_expected.to have_many(:reverse_friendships) }
    it { is_expected.to have_many(:friends) }
  end
end
