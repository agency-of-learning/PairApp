require 'rails_helper'

RSpec.describe MenteeApplicationMailer do
  let(:application) { create(:user_mentee_application) }
  let(:recipient) { application.user }

  describe '#notify_for_acceptance' do
    subject(:mail) { described_class.with(recipient:, application:).notify_for_acceptance }

    it 'renders the headers' do
      expect(mail.subject).to eq('Welcome to the Agency of Learning!')
      expect(mail.to).to eq([recipient.email])
      expect(mail.from).to eq(['dave@agencyoflearning.com'])
      expect(mail.bcc).to eq(['dave@agencyoflearning.com'])
    end
  end

  describe '#notify_for_rejection' do
    subject(:mail) { described_class.with(recipient:).notify_for_rejection }

    it 'renders the headers' do
      expect(mail.subject).to eq('Update on your application to the Agency of Learning')
      expect(mail.to).to eq([recipient.email])
      expect(mail.from).to eq(['dave@agencyoflearning.com'])
      expect(mail.bcc).to eq(['dave@agencyoflearning.com'])
    end
  end

  describe '#notify_for_code_challenge_sent' do
    subject(:mail) { described_class.with(recipient:).notify_for_code_challenge_sent }

    it 'renders the headers' do
      expect(mail.subject).to eq('Moving forward in the application process for the Agency of Learning')
      expect(mail.to).to eq([recipient.email])
      expect(mail.from).to eq(['dave@agencyoflearning.com'])
      expect(mail.bcc).to eq(['dave@agencyoflearning.com'])
    end
  end

  describe '#notify_for_code_challenge_approved' do
    subject(:mail) { described_class.with(recipient:).notify_for_code_challenge_approved }

    it 'renders the headers' do
      expect(mail.subject).to eq('Moving forward in the application process for the Agency of Learning')
      expect(mail.to).to eq([recipient.email])
      expect(mail.from).to eq(['dave@agencyoflearning.com'])
      expect(mail.bcc).to eq(['dave@agencyoflearning.com'])
    end
  end
end
