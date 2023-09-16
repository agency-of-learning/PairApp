require 'rails_helper'
RSpec.describe UserMenteeApplicationMailer do
  let(:application) { create(:user_mentee_application) }
  let(:recipient) { application.user }

  describe '#notify_for_application_submission' do
    subject(:mail) do
      described_class.with(user_mentee_application: application, recipient:).notify_for_application_submission
    end

    it 'renders the headers' do
      expect(mail.subject).to eq('Woohoo! Your Application’s In - Agency of Learning.')
      expect(mail.to).to eq([recipient.email])
      expect(mail.from).to eq(['no_reply@agencyoflearning.com'])
    end
  end
end
