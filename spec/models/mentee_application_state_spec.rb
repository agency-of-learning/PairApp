# spec/models/mentee_application_state_spec.rb
require 'rails_helper'

RSpec.describe MenteeApplicationState do
  describe 'friendly_id' do
    let(:user_mentee_application) { create(:user_mentee_application) }
    let(:mentee_application_state) do
      create(:mentee_application_state, status: 'coding_challenge_sent',
        user_mentee_application_id: user_mentee_application.id)
    end

    context 'when a new mentee application state is created' do
      it 'creates a slug' do
        expect(mentee_application_state.slug).to eq('coding_challenge_sent')
      end
    end
  end

  describe 'slug validation' do
    subject(:mentee_application_state) { build(:mentee_application_state) }

    it 'does not allow duplicate slugs' do
      expect { subject.update!(slug: 'application_received') }.to raise_error(ActiveRecord::RecordNotUnique)
    end
  end
end
