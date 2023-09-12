# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MenteeApplicationTransitionService do
  let(:reviewer) { create(:user) }
  let(:user) { create(:user) }
  let(:application_received) { create(:user_mentee_application, :application_received, user:) }
  let(:coding_challenge_sent) { create(:user_mentee_application, :coding_challenge_sent, user:) }
  let(:coding_challenge_received) { create(:user_mentee_application, :coding_challenge_received, user:) }
  let(:coding_challenge_approved) { create(:user_mentee_application, :coding_challenge_approved, user:) }
  let(:phone_screen_scheduled) { create(:user_mentee_application, :phone_screen_scheduled, user:) }
  let(:phone_screen_completed) { create(:user_mentee_application, :phone_screen_completed, user:) }
  let(:accepted) { create(:user_mentee_application, :accepted, user:) }
  let(:rejected) { create(:user_mentee_application, :rejected, user:) }

  describe '.promote!' do
    context 'when the application has been received' do
      it 'promotes the application to the next status'
    end

    context 'when the coding challenge has been sent' do
      it 'promotes the application to the next status'
    end

    context 'when the coding challenge has been received' do
      it 'promotes the application to the next status'
    end

    context 'when the phone screen has been scheduled' do
      it 'promotes the application to the next status'
    end

    context 'when the phone screen has been completed' do
      it 'promotes the application to the next status' do
        described_class.promote!(application: phone_screen_completed, user: reviewer)
        expect(phone_screen_completed.reload.current_status).to eq('accepted')
      end
    end

    context 'when the application has been accepted' do
      it 'raises an invalid transition error' do
        expect {
          described_class.promote!(application: accepted, user: reviewer)
        }.to raise_error MenteeApplicationTransitionService::InvalidTransitionError
      end
    end

    context 'when the application has been rejected' do
      it 'raises an invalid transition error' do
        expect {
          described_class.promote!(application: rejected, user: reviewer)
        }.to raise_error MenteeApplicationTransitionService::InvalidTransitionError
      end
    end
  end
end
