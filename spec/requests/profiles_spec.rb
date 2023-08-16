require 'rails_helper'

RSpec.describe 'Profiles' do
  describe '#show' do
    let!(:user) { create(:user, first_name: 'Jim', last_name: 'Bob') }
    let!(:profile) { create(:profile, user: user, slug: user.full_name.parameterize) }

    before do
      sign_in user
    end

    context 'when provided a slug' do

      before do
        get "/profiles/#{user.full_name.parameterize}"
      end

      it 'returns a profile' do
        expect(response).to have_http_status(:ok)
        expect(response.body).to include(user.full_name)
      end
    end

    context 'when provided an id' do
      before do
        get "/profiles/#{profile.id}"
      end

      it 'returns a profile' do
        expect(response).to have_http_status(:ok)
        expect(response.body).to include(user.full_name)
      end
    end

    context 'when provided an invalid id' do
      it 'returns an error' do
        expect {
          get '/profiles/not-really-an-id'
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
