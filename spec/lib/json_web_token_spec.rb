# frozen_string_literal: true

require 'rails_helper'
require 'json_web_token'

RSpec.describe JsonWebToken do
  let(:expiry) { '01/01/3022'.to_datetime }
  let(:payload) { { foo: :bar, lorem: :ipsum } }

  describe '.encode' do
    it 'returns an encoded token' do
      token = JsonWebToken.encode(payload, expiry)
      expect(token).to be_a String
      expect(JWT.decode(token, JsonWebToken::SECRET_KEY, JsonWebToken::ALGORITHM))
        .to eq [
          { 'foo' => 'bar', 'lorem' => 'ipsum', 'exp' => 33_197_904_000 },
          { 'alg' => 'HS256' }
        ]
    end
  end

  describe '.decode' do
    let(:token) do
      'eyJhbGciOiJIUzI1NiJ9.eyJmb28iOiJiYXIiLCJsb3JlbSI6Imlwc3VtIiwiZXhwIjozMzE5NzkwNDAwMH0.7zyS9tjW8sauiRlB7iXAn7baQFAJcTcJNk1JcOXcKck'
    end

    it 'returns the decoded payload' do
      expect(JsonWebToken.decode(token))
        .to eq({ 'foo' => 'bar', 'lorem' => 'ipsum', 'exp' => 33_197_904_000 })
    end
  end
end
