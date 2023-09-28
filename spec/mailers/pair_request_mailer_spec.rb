require 'rails_helper'

RSpec.describe PairRequestMailer do
  let(:pair_request) { create(:pair_request) }
  let(:completed_pair_request) { create(:pair_request, :completed_with_feedback) }
  let(:recipient) { pair_request.invitee }

  describe '#notify_invitee_of_new_pair_request' do
    subject(:mail) { described_class.with(recipient:, pair_request:).notify_invitee_of_new_pair_request }

    it 'renders the headers' do
      expect(mail.subject).to eq('Pair Request Invite')
      expect(mail.to).to eq([recipient.email])
      expect(mail.from).to eq(['no_reply@agencyoflearning.com'])
    end
  end

  describe '#notify_author_of_accepted_request' do
    subject(:mail) { described_class.with(recipient:, pair_request:).notify_author_of_accepted_request }

    it 'renders the headers' do
      expect(mail.subject).to eq('Pair Request Accepted')
      expect(mail.to).to eq([recipient.email])
      expect(mail.from).to eq(["no_reply@agencyoflearning.com"])
    end
  end

  describe '#notify_invitee_of_completed_pairing_session' do
    subject(:mail) { described_class.with(recipient:, pair_request: completed_pair_request).notify_invitee_of_completed_pairing_session }

    it 'renders the headers' do
      expect(mail.subject).to eq('Pair Request Completed')
      expect(mail.to).to eq([recipient.email])
      expect(mail.from).to eq(["no_reply@agencyoflearning.com"])
    end
  end

  describe '#notify_author_of_concluded_pairing_session' do
    subject(:mail) { described_class.with(recipient:, pair_request:).notify_author_of_concluded_pairing_session }

    it 'renders the headers' do
      expect(mail.subject).to eq('Mark Pair Request as Completed')
      expect(mail.to).to eq([recipient.email])
      expect(mail.from).to eq(["no_reply@agencyoflearning.com"])
    end
  end
end
