require 'rails_helper'

RSpec.describe MenteeApplicationMailer do
  let(:recipient) { create(:user) }

  describe '#notify_for_acceptance' do
    subject(:mail) { described_class.with(recipient:).notify_for_acceptance }

    it 'renders the headers' do
      expect(mail.subject).to eq('Welcome to the Agency of Learning!')
      expect(mail.to).to eq([recipient.email])
      expect(mail.from).to eq(['no_reply@agencyoflearning.com'])
    end
  end

  describe '#notify_for_rejection' do
    subject(:mail) { described_class.with(recipient:).notify_for_rejection }

    it 'renders the headers' do
      expect(mail.subject).to eq('Update on your application to the Agency of Learning')
      expect(mail.to).to eq([recipient.email])
      expect(mail.from).to eq(['no_reply@agencyoflearning.com'])
    end
  end
end
