require 'rails_helper'

RSpec.describe FeedbackPolicy do
  subject { described_class }

  let(:user) { build(:user) }
  let(:admin) { build(:user, :admin) }

  let(:not_owned_feedback) { build(:feedback) }
  let(:authored_feedback) { build(:feedback, author: user, locked_at:) }
  let(:received_feedback) { build(:feedback, receiver: user) }
  let(:locked_at) { nil }

  permissions :index?, :show? do
    it 'denies access if the user is not an owner of the request' do
      expect(subject).not_to permit(user, not_owned_feedback)
    end

    it 'grants access when the user is the author' do
      expect(subject).to permit(user, authored_feedback)
    end

    it 'grants access when the user is the receiver' do
      expect(subject).to permit(user, received_feedback)
    end

    it 'grants access when the user is an admin' do
      expect(subject).to permit(admin, not_owned_feedback)
    end
  end

  permissions :edit?, :update? do
    context 'when the user is not the author' do
      it 'denies access to a member user' do
        expect(subject).not_to permit(user, received_feedback)
      end

      it 'grants access to an admin user' do
        expect(subject).to permit(admin, not_owned_feedback)
      end
    end

    context 'when the user is the author and the feedback is locked' do
      let(:locked_at) { Date.yesterday }

      it 'denies access' do
        expect(subject).not_to permit(user, authored_feedback)
      end
    end

    context "when the user is the author and the feedback isn't locked" do
      let(:locked_at) { Date.tomorrow }

      it 'grants access' do
        expect(subject).to permit(user, authored_feedback)
      end
    end
  end

  permissions :destroy? do
    it 'denies access to a member user' do
      expect(subject).not_to permit(user, authored_feedback)
    end

    it 'grants access to an admin' do
      expect(subject).to permit(admin, not_owned_feedback)
    end
  end
end
