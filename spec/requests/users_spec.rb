require 'rails_helper'

RSpec.describe "/useærs", type: :request do
  let(:valid_attributes) {
    skip('Add a hash of attributes valid for your model')
  }

  let(:invalid_attributes) {
    skip('Add a hash of attributes invalid for your model')
  }

  let(:valid_headers) {
    {}
  }

  describe 'GET /index' do
    it 'renders a successful response' do
      User.create! valid_attributes
      get users_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end
end
