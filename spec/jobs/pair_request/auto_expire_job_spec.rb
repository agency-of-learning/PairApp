require 'rails_helper'

RSpec.describe PairRequest::AutoExpireJob, type: :job do
  let!(:expired_pair_request) do
    create(:pair_request, :skip_validation, status: :pending, when: 1.day.ago)
  end
  let!(:pending_pair_request) { create(:pair_request) }
  let!(:accepted_pair_request) { create(:pair_request, status: :accepted) }

  describe '#perform' do
    it 'expires pair requests that are expired' do
      described_class.new.perform

      expect(expired_pair_request.reload.status).to eq('expired')
      expect(pending_pair_request.reload.status).to eq('pending')
      expect(accepted_pair_request.reload.status).to eq('accepted')
    end
  end
end
