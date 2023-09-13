# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MenteeApplicationTransitionService do
  let(:reviewer) { create(:user) }
  let(:user) { create(:user, :applicant) }
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
      it 'promotes the application to the next status' do
        expect {
          described_class.promote!(application: application_received, reviewer:)
        }.to change {
          application_received.reload.current_status
        }.from('application_received').to('coding_challenge_sent')
      end

      it 'enqueues an accepted mailer' do
        expect {
          described_class.promote!(application: application_received, reviewer:)
        }.to have_enqueued_mail(MenteeApplicationMailer, :notify_for_code_challenge)
      end
    end

    context 'when the coding challenge has been sent' do
      it 'promotes the application to the next status' do
        expect {
          described_class.promote!(application: coding_challenge_sent, reviewer:)
        }.to change {
          coding_challenge_sent.reload.current_status
        }.from('coding_challenge_sent').to('coding_challenge_received')
      end
    end

    context 'when the coding challenge has been received' do
      it 'promotes the application to the next status' do
        expect {
          described_class.promote!(application: coding_challenge_received, reviewer:)
        }.to change {
          coding_challenge_received.reload.current_status
        }.from('coding_challenge_received').to('coding_challenge_approved')
      end
    end

    context 'when the coding challenge has been approved' do
      it 'promotes the application to the next status' do
        expect {
          described_class.promote!(application: coding_challenge_approved, reviewer:)
        }.to change {
          coding_challenge_approved.reload.current_status
        }.from('coding_challenge_approved').to('phone_screen_scheduled')
      end
    end

    context 'when the phone screen has been scheduled' do
      it 'promotes the application to the next status' do
        expect {
          described_class.promote!(application: phone_screen_scheduled, reviewer:)
        }.to change {
          phone_screen_scheduled.reload.current_status
        }.from('phone_screen_scheduled').to('phone_screen_completed')
      end
    end

    context 'when the phone screen has been completed' do
      it 'promotes the application to the next status' do
        described_class.promote!(application: phone_screen_completed, reviewer:)
        expect(phone_screen_completed.reload.current_status).to eq('accepted')
      end

      it 'enqueues an accepted mailer' do
        expect {
          described_class.promote!(application: phone_screen_completed, reviewer:)
        }.to have_enqueued_mail(MenteeApplicationMailer, :notify_for_acceptance)
      end

      it "updates the applicant's role to member" do
        expect {
          described_class.promote!(application: phone_screen_completed, reviewer:)
        }.to change { phone_screen_completed.user.role }.from('applicant').to('member')
      end
    end

    context 'when the application has been accepted' do
      it 'raises an invalid transition error' do
        expect {
          described_class.promote!(application: accepted, reviewer:)
        }.to raise_error MenteeApplicationTransitionService::InvalidTransitionError
      end
    end

    context 'when the application has been rejected' do
      it 'raises an invalid transition error' do
        expect {
          described_class.promote!(application: rejected, reviewer:)
        }.to raise_error MenteeApplicationTransitionService::InvalidTransitionError
      end
    end
  end

  describe '.reject!' do
    context 'when the application has been received' do
      it 'rejects the application' do
        expect {
          described_class.reject!(application: application_received, reviewer:)
        }.to change {
          application_received.reload.current_status
        }.from('application_received').to('rejected')
      end

      it 'enqueues a rejection mailer' do
        expect {
          described_class.reject!(application: application_received, reviewer:)
        }.to have_enqueued_mail(MenteeApplicationMailer, :notify_for_rejection)
      end
    end

    context 'when the coding challenge has been sent' do
      it 'raises an invalid transition error' do
        expect {
          described_class.reject!(application: coding_challenge_sent, reviewer:)
        }.to raise_error MenteeApplicationTransitionService::InvalidTransitionError
      end
    end

    context 'when the coding challenge has been received' do
      it 'rejects the application' do
        expect {
          described_class.reject!(application: coding_challenge_received, reviewer:)
        }.to change {
          coding_challenge_received.reload.current_status
        }.from('coding_challenge_received').to('rejected')
      end

      it 'enqueues a rejection mailer' do
        expect {
          described_class.reject!(application: coding_challenge_received, reviewer:)
        }.to have_enqueued_mail(MenteeApplicationMailer, :notify_for_rejection)
      end
    end

    context 'when the coding challenge has been approved' do
      it 'raises an invalid transition error' do
        expect {
          described_class.reject!(application: coding_challenge_approved, reviewer:)
        }.to raise_error MenteeApplicationTransitionService::InvalidTransitionError
      end
    end

    context 'when the phone screen has been scheduled' do
      it 'raises an invalid transition error' do
        expect {
          described_class.reject!(application: phone_screen_scheduled, reviewer:)
        }.to raise_error MenteeApplicationTransitionService::InvalidTransitionError
      end
    end

    context 'when the phone screen has been completed' do
      it 'rejects the application' do
        expect {
          described_class.reject!(application: phone_screen_completed, reviewer:)
        }.to change {
          phone_screen_completed.reload.current_status
        }.from('phone_screen_completed').to('rejected')
      end

      it 'enqueues a rejection mailer' do
        expect {
          described_class.reject!(application: phone_screen_completed, reviewer:)
        }.to have_enqueued_mail(MenteeApplicationMailer, :notify_for_rejection)
      end
    end

    context 'when the application has been accepted' do
      it 'raises an invalid transition error' do
        expect {
          described_class.reject!(application: accepted, reviewer:)
        }.to raise_error MenteeApplicationTransitionService::InvalidTransitionError
      end
    end

    context 'when the application has been rejected' do
      it 'raises an invalid transition error' do
        expect {
          described_class.reject!(application: rejected, reviewer:)
        }.to raise_error MenteeApplicationTransitionService::InvalidTransitionError
      end
    end
  end
end
