# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NavigationComponent, type: :component do
  describe '.for' do
    subject { described_class.for(current_user: user) }

    let(:user) { build(:user, role:) }

    context 'when passed a member user' do
      let(:role) { :member }

      it 'returns a `MemberComponent`' do
        expect(subject).to be_a Navigation::MemberComponent
      end
    end

    context 'when passed a admin user' do
      let(:role) { :admin }

      it 'returns a `AdminComponent`' do
        expect(subject).to be_a Navigation::AdminComponent
      end
    end

    context 'when passed a moderator user' do
      let(:role) { :moderator }

      it 'returns a `ModeratorComponent`' do
        expect(subject).to be_a Navigation::ModeratorComponent
      end
    end

    context 'when passed a applicant user' do
      let(:role) { :applicant }

      it 'returns a `ApplicantComponent`' do
        expect(subject).to be_a Navigation::ApplicantComponent
      end
    end

    context 'when passed a nil user' do
      let(:user) { nil }

      it 'returns a `GuestComponent`' do
        expect(subject).to be_a Navigation::GuestComponent
      end
    end
  end
end
