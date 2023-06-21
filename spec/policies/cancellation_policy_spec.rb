require 'rails_helper'
RSpec.describe PairRequest::CancellationPolicy do
  subject { described_class }

  let(:user) { build(:user) }
  let(:author) { build(:user) }
  let(:pending_pair_request) { build(:pair_request, author:) }
  let(:expired_pair_request) { build(:pair_request, status: :expired, author:) }
  let(:accepted_pair_request) { build(:pair_request, status: :accepted, author:) }
  let(:rejected_pair_request) { build(:pair_request, status: :rejected, author:) }
  let(:completed_pair_request) { build(:pair_request, status: :completed, author:) }
  let(:cancelled_pair_request) { build(:pair_request, status: :cancelled, author:) }

  permissions :create? do
    context 'user is the author' do
      it 'grants access if the request is pending' do
        expect(subject).to permit(author, pending_pair_request)
      end

      it 'grants access if the request is accepted' do
        expect(subject).to permit(author, accepted_pair_request)
      end

      it 'denies access if the request is rejected' do
        expect(subject).not_to permit(author, rejected_pair_request)
      end

      it 'denies access if the request is expired' do
        expect(subject).not_to permit(author, expired_pair_request)
      end

      it 'denies access if the request is completed' do
        expect(subject).not_to permit(author, completed_pair_request)
      end

      it 'denies access if the request is cancelled' do
        expect(subject).not_to permit(author, cancelled_pair_request)
      end
    end

    it 'denies access if the user is not the author' do
      expect(subject).not_to permit(user, pending_pair_request)
    end
  end
end
