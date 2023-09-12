# == Schema Information
#
# Table name: mentee_application_states
#
#  id                         :bigint           not null, primary key
#  note                       :text
#  status                     :integer          default("application_received"), not null
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  status_changed_id          :bigint
#  user_mentee_application_id :bigint           not null
#
# Indexes
#
#  index_mentee_application_states_on_status_changed_id           (status_changed_id)
#  index_mentee_application_states_on_user_mentee_application_id  (user_mentee_application_id)
#
# Foreign Keys
#
#  fk_rails_...  (status_changed_id => users.id)
#  fk_rails_...  (user_mentee_application_id => user_mentee_applications.id)
#
require 'rails_helper'

RSpec.describe MenteeApplicationState do
  describe '.next' do
    context 'when the status is application_received' do
      let(:status) { :application_received }

      it 'returns the next status' do
        expect(described_class.next(status:)).to eq('coding_challenge_sent')
      end
    end

    context 'when the status is coding_challenge_sent' do
      let(:status) { :coding_challenge_sent }

      it 'returns the next status' do
        expect(described_class.next(status:)).to eq('coding_challenge_received')
      end
    end

    context 'when the status is coding_challenge_received' do
      let(:status) { :coding_challenge_received }

      it 'returns the next status' do
        expect(described_class.next(status:)).to eq('coding_challenge_approved')
      end
    end

    context 'when the status is coding_challenge_approved' do
      let(:status) { :coding_challenge_approved }

      it 'returns the next status' do
        expect(described_class.next(status:)).to eq('phone_screen_scheduled')
      end
    end

    context 'when the status is phone_screen_scheduled' do
      let(:status) { :phone_screen_scheduled }

      it 'returns the next status' do
        expect(described_class.next(status:)).to eq('phone_screen_completed')
      end
    end

    context 'when the status is phone_screen_completed' do
      let(:status) { :phone_screen_completed }

      it 'returns the next status' do
        expect(described_class.next(status:)).to eq('accepted')
      end
    end

    context 'when the status is accepted' do
      let(:status) { :accepted }

      it 'returns no next status' do
        expect(described_class.next(status:)).to be_nil
      end
    end

    context 'when the status is rejected' do
      let(:status) { :rejected }

      it 'returns no next status' do
        expect(described_class.next(status:)).to be_nil
      end
    end
  end
end
