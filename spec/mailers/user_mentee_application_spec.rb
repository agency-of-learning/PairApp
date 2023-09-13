require 'rails_helper'

RSpec.describe UserMenteeApplicationMailer do
  let(:mentee_application) { create(:user_mentee_application) }
  let(:recipient) { mentee_application.user }

  describe '#notify_for_application_submission' do
    subject(:mail) { described_class.notify_for_application_submission(mentee_application) }

    it 'renders the headers' do
      expect(:mail.subject).to eq('Mentee Application Submitted')
      expect(:mail.to).to eq([recipient.email])
      expect(mail.from).to eq(['no_reply@agencyoflearning.com'])
    end
  end

end
