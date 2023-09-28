require 'rails_helper'

RSpec.describe MenteeApplicationMailer do
  let(:application) { create(:user_mentee_application) }
  let(:recipient) { application.user }

  describe '#notify_applicant_of_acceptance' do
    subject(:mail) { described_class.with(recipient:, application:).notify_applicant_of_acceptance }

    it 'renders the headers' do
      expect(mail.subject).to eq('Welcome to the Agency of Learning!')
      expect(mail.to).to eq([recipient.email])
      expect(mail.from).to eq(['dave@agencyoflearning.com'])
      expect(mail.bcc).to eq(['dave@agencyoflearning.com'])
    end
  end

  describe '#notify_applicant_of_rejection' do
    subject(:mail) { described_class.with(recipient:).notify_applicant_of_rejection }

    it 'renders the headers' do
      expect(mail.subject).to eq('Update on your application to the Agency of Learning')
      expect(mail.to).to eq([recipient.email])
      expect(mail.from).to eq(['dave@agencyoflearning.com'])
      expect(mail.bcc).to eq(['dave@agencyoflearning.com'])
    end
  end

  describe '#notify_applicant_of_code_challenge_sent' do
    subject(:mail) { described_class.with(recipient:).notify_applicant_of_code_challenge_sent }

    it 'renders the headers' do
      expect(mail.subject).to eq('Moving forward in the application process for the Agency of Learning')
      expect(mail.to).to eq([recipient.email])
      expect(mail.from).to eq(['dave@agencyoflearning.com'])
      expect(mail.bcc).to eq(['dave@agencyoflearning.com'])
    end
  end

  describe '#notify_applicant_of_code_challenge_approved' do
    subject(:mail) { described_class.with(recipient:).notify_applicant_of_code_challenge_approved }

    it 'renders the headers' do
      expect(mail.subject).to eq('Moving forward in the application process for the Agency of Learning')
      expect(mail.to).to eq([recipient.email])
      expect(mail.from).to eq(['dave@agencyoflearning.com'])
      expect(mail.bcc).to eq(['dave@agencyoflearning.com'])
    end
  end

  describe '#notify_applicant_to_reapply' do
    subject(:mail) { described_class.with(recipient:, active_cohort_name: 'Fall 2023').notify_applicant_to_reapply }

    it 'renders the headers' do
      expect(mail.subject).to eq('Invitation to Apply to the Agency of Learning')
      expect(mail.to).to eq([recipient.email])
      expect(mail.from).to eq(['dave@agencyoflearning.com'])
    end
  end

  describe '#notify_admin_of_submission' do
    subject(:mail) do
      described_class.with(application:, recipient:).notify_admin_of_submission
    end

    it 'renders the headers' do
      expect(mail.subject).to eq("[#{application.cohort.name} Cohort Submission] #{application.user.full_name}")
      expect(mail.to).to eq([recipient.email])
      expect(mail.bcc).to be_nil
      expect(mail.from).to eq(['no_reply@agencyoflearning.com'])
    end
  end

  describe '#notify_applicant_of_submission' do
    subject(:mail) do
      described_class.with(application:, recipient:).notify_applicant_of_submission
    end

    it 'renders the headers' do
      expect(mail.subject).to eq('Woohoo! We got your application to the Agency of Learning')
      expect(mail.to).to eq([recipient.email])
      expect(mail.from).to eq(['dave@agencyoflearning.com'])
      expect(mail.bcc).to eq(['dave@agencyoflearning.com'])
    end
  end
end
