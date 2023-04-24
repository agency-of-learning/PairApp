require 'rails_helper'

RSpec.describe '/users', type: :request do
  let!(:user) { create(:user) }

  describe 'GET /show' do
    it 'returns a success response' do
      # get user_url(user)
      # expect(response).to be_successful
    end
  end
end
