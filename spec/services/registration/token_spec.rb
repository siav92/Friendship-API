# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Registration::Token do
  let(:user) { create(:user, email: 'employee@company.com') }

  describe '.generate_user_token' do
    it 'returns an encoded token' do
      token = Registration::Token.generate_user_token(user)
      expect(token).to be_a String
      expect(JWT.decode(token, JsonWebToken::SECRET_KEY, JsonWebToken::ALGORITHM).first)
        .to include('email' => user.email)
    end
  end

  describe '.decode_user_token' do
    let(:token) do
      'eyJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6ImVtcGxveWVlQGNvbXBhbnkuY29tIiwiZXhwIjoxNjcwNjE4NjA0fQ.YnZ5yzMua484cbvTN2_QA0oevsGQm2M4eWiq5YzTGPU'
    end

    it 'returns the decoded payload' do
      expect(Registration::Token.decode_user_token(token))
        .to include('email' => user.email)
    end
  end
end
