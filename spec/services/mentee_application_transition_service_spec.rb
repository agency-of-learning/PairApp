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
  let(:withdrawn) { create(:user_mentee_application, :withdrawn, user:) }
  let(:accepted) { create(:user_mentee_application, :accepted, user:) }
  let(:rejected) { create(:user_mentee_application, :rejected, user:) }

  describe '.call' do
    context 'when the action is :promote' do
      let(:action) { :promote }

      context 'when the application has been received' do
        it 'promotes the application to the next status' do
          expect {
            described_class.call(application: application_received, reviewer:, action:)
          }.to change {
            application_received.reload.current_status
          }.from('application_received').to('coding_challenge_sent')
        end

        it 'enqueues an accepted mailer' do
          expect {
            described_class.call(application: application_received, reviewer:, action:)
          }.to have_enqueued_mail(MenteeApplicationMailer, :notify_applicant_of_code_challenge_sent)
        end
      end

      context 'when the coding challenge has been sent' do
        it 'promotes the application to the next status' do
          expect {
            described_class.call(application: coding_challenge_sent, reviewer:, action:)
          }.to change {
            coding_challenge_sent.reload.current_status
          }.from('coding_challenge_sent').to('coding_challenge_received')
        end
      end

      context 'when the coding challenge has been received' do
        it 'promotes the application to the next status' do
          expect {
            described_class.call(application: coding_challenge_received, reviewer:, action:)
          }.to change {
            coding_challenge_received.reload.current_status
          }.from('coding_challenge_received').to('coding_challenge_approved')
        end

        it 'enqueues a mailer notifying to schedule an interview' do
          expect {
            described_class.call(application: coding_challenge_received, reviewer:, action:)
          }.to have_enqueued_mail(MenteeApplicationMailer, :notify_applicant_of_code_challenge_approved)
        end
      end

      context 'when the coding challenge has been approved' do
        it 'promotes the application to the next status' do
          expect {
            described_class.call(application: coding_challenge_approved, reviewer:, action:)
          }.to change {
            coding_challenge_approved.reload.current_status
          }.from('coding_challenge_approved').to('phone_screen_scheduled')
        end
      end

      context 'when the phone screen has been scheduled' do
        it 'promotes the application to the next status' do
          expect {
            described_class.call(application: phone_screen_scheduled, reviewer:, action:)
          }.to change {
            phone_screen_scheduled.reload.current_status
          }.from('phone_screen_scheduled').to('phone_screen_completed')
        end
      end

      context 'when the phone screen has been completed' do
        it 'promotes the application to the next status' do
          described_class.call(application: phone_screen_completed, reviewer:, action:)
          expect(phone_screen_completed.reload.current_status).to eq('accepted')
        end

        it 'enqueues an accepted mailer' do
          expect {
            described_class.call(application: phone_screen_completed, reviewer:, action:)
          }.to have_enqueued_mail(MenteeApplicationMailer, :notify_applicant_of_acceptance)
        end

        it "updates the applicant's role to member" do
          expect {
            described_class.call(application: phone_screen_completed, reviewer:, action:)
          }.to change { phone_screen_completed.user.role }.from('applicant').to('member')
        end
      end

      context 'when the application has been accepted' do
        it 'raises an invalid transition error' do
          expect {
            described_class.call(application: accepted, reviewer:, action:)
          }.to raise_error MenteeApplicationTransitionService::InvalidTransitionError
        end
      end

      context 'when the application has been rejected' do
        it 'raises an invalid transition error' do
          expect {
            described_class.call(application: rejected, reviewer:, action:)
          }.to raise_error MenteeApplicationTransitionService::InvalidTransitionError
        end
      end

      context 'when the application has been withdrawn' do
        it 'raises an invalid transition error' do
          expect {
            described_class.call(application: withdrawn, reviewer:, action:)
          }.to raise_error MenteeApplicationTransitionService::InvalidTransitionError
        end
      end
    end

    context 'when the action is :reject' do
      let(:action) { :reject }

      context 'when the application has been received' do
        it 'rejects the application' do
          expect {
            described_class.call(application: application_received, reviewer:, action:)
          }.to change {
            application_received.reload.current_status
          }.from('application_received').to('rejected')
        end

        it 'enqueues a rejection mailer' do
          expect {
            described_class.call(application: application_received, reviewer:, action:)
          }.to have_enqueued_mail(MenteeApplicationMailer, :notify_applicant_of_rejection)
        end
      end

      context 'when the coding challenge has been sent' do
        it 'raises an invalid transition error' do
          expect {
            described_class.call(application: coding_challenge_sent, reviewer:, action:)
          }.to raise_error MenteeApplicationTransitionService::InvalidTransitionError
        end
      end

      context 'when the coding challenge has been received' do
        it 'rejects the application' do
          expect {
            described_class.call(application: coding_challenge_received, reviewer:, action:)
          }.to change {
            coding_challenge_received.reload.current_status
          }.from('coding_challenge_received').to('rejected')
        end

        it 'enqueues a rejection mailer' do
          expect {
            described_class.call(application: coding_challenge_received, reviewer:, action:)
          }.to have_enqueued_mail(MenteeApplicationMailer, :notify_applicant_of_rejection)
        end
      end

      context 'when the coding challenge has been approved' do
        it 'raises an invalid transition error' do
          expect {
            described_class.call(application: coding_challenge_approved, reviewer:, action:)
          }.to raise_error MenteeApplicationTransitionService::InvalidTransitionError
        end
      end

      context 'when the phone screen has been scheduled' do
        it 'raises an invalid transition error' do
          expect {
            described_class.call(application: phone_screen_scheduled, reviewer:, action:)
          }.to raise_error MenteeApplicationTransitionService::InvalidTransitionError
        end
      end

      context 'when the phone screen has been completed' do
        it 'rejects the application' do
          expect {
            described_class.call(application: phone_screen_completed, reviewer:, action:)
          }.to change {
            phone_screen_completed.reload.current_status
          }.from('phone_screen_completed').to('rejected')
        end

        it 'enqueues a rejection mailer' do
          expect {
            described_class.call(application: phone_screen_completed, reviewer:, action:)
          }.to have_enqueued_mail(MenteeApplicationMailer, :notify_applicant_of_rejection)
        end
      end

      context 'when the application has been accepted' do
        it 'raises an invalid transition error' do
          expect {
            described_class.call(application: accepted, reviewer:, action:)
          }.to raise_error MenteeApplicationTransitionService::InvalidTransitionError
        end
      end

      context 'when the application has been rejected' do
        it 'raises an invalid transition error' do
          expect {
            described_class.call(application: rejected, reviewer:, action:)
          }.to raise_error MenteeApplicationTransitionService::InvalidTransitionError
        end
      end
    end

    context 'when the action is withdrawn' do
      let(:action) { :withdrawn }

      context 'when the application has been received' do
        it 'withdraws the application' do
          expect {
            described_class.call(application: application_received, reviewer:, action:)
          }.to change {
            application_received.reload.current_status
          }.from('application_received').to('withdrawn')
        end

        it 'enqueues a withdrawal mailer' do
          expect {
            described_class.call(application: application_received, reviewer:, action:)
          }.to have_enqueued_mail(MenteeApplicationMailer, :notify_applicant_of_withdrawal)
        end
      end

      context 'when the coding challenge has been sent' do
        it 'withdraws the application' do
          expect {
            described_class.call(application: coding_challenge_sent, reviewer:, action:)
          }.to change {
            coding_challenge_sent.reload.current_status
          }.from('coding_challenge_sent').to('withdrawn')
        end

        it 'enqueues a withdrawal mailer' do
          expect {
            described_class.call(application: coding_challenge_sent, reviewer:, action:)
          }.to have_enqueued_mail(MenteeApplicationMailer, :notify_applicant_of_withdrawal)
        end
      end

      context 'when the coding challenge has been received' do
        it 'withdraws the application' do
          expect {
            described_class.call(application: coding_challenge_received, reviewer:, action:)
          }.to change {
            coding_challenge_received.reload.current_status
          }.from('coding_challenge_received').to('withdrawn')
        end

        it 'enqueues a withdrawal mailer' do
          expect {
            described_class.call(application: coding_challenge_received, reviewer:, action:)
          }.to have_enqueued_mail(MenteeApplicationMailer, :notify_applicant_of_withdrawal)
        end
      end

      context 'when the coding challenge has been approved' do
        it 'withdraws the application' do
          expect {
            described_class.call(application: coding_challenge_approved, reviewer:, action:)
          }.to change {
            coding_challenge_approved.reload.current_status
          }.from('coding_challenge_approved').to('withdrawn')
        end

        it 'enqueues a withdrawal mailer' do
          expect {
            described_class.call(application: coding_challenge_approved, reviewer:, action:)
          }.to have_enqueued_mail(MenteeApplicationMailer, :notify_applicant_of_withdrawal)
        end
      end

      context 'when the phone screen has been scheduled' do
        it 'withdraws the application' do
          expect {
            described_class.call(application: phone_screen_scheduled, reviewer:, action:)
          }.to change {
            phone_screen_scheduled.reload.current_status
          }.from('phone_screen_scheduled').to('withdrawn')
        end

        it 'enqueues a withdrawal mailer' do
          expect {
            described_class.call(application: phone_screen_scheduled, reviewer:, action:)
          }.to have_enqueued_mail(MenteeApplicationMailer, :notify_applicant_of_withdrawal)
        end
      end

      context 'when the phone screen has been completed' do
        it 'withdraws the application' do
          expect {
            described_class.call(application: phone_screen_completed, reviewer:, action:)
          }.to change {
            phone_screen_completed.reload.current_status
          }.from('phone_screen_completed').to('withdrawn')
        end

        it 'enqueues a withdrawal mailer' do
          expect {
            described_class.call(application: phone_screen_completed, reviewer:, action:)
          }.to have_enqueued_mail(MenteeApplicationMailer, :notify_applicant_of_withdrawal)
        end
      end

      context 'when the application has been accepted' do
        it 'raises an invalid transition error' do
          expect {
            described_class.call(application: accepted, reviewer:, action:)
          }.to raise_error MenteeApplicationTransitionService::InvalidTransitionError
        end
      end

      context 'when the application has been rejected' do
        it 'raises an invalid transition error' do
          expect {
            described_class.call(application: rejected, reviewer:, action:)
          }.to raise_error MenteeApplicationTransitionService::InvalidTransitionError
        end
      end

      context 'when the application has been withdrawn' do
        it 'raises an invalid transition error' do
          expect {
            described_class.call(application: withdrawn, reviewer:, action:)
          }.to raise_error MenteeApplicationTransitionService::InvalidTransitionError
        end
      end
    end
  end

  describe '.valid_transitions' do
    it 'returns the valid transitions for the current status' do
      MenteeApplicationState.statuses.each_key do |status|
        expect(
          described_class.valid_transitions(status:)
        ).to eq MenteeApplicationTransitionService::STATUS_TRANSITION_MAPPING[status.to_sym][:valid_transitions]
      end
    end

    it 'raises an invalid status error if the status is not part of the state machine' do
      expect {
        described_class.valid_transitions(status: 'cheese')
      }.to raise_error MenteeApplicationTransitionService::InvalidStatusError
    end
  end
end
