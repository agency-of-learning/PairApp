# == Schema Information
#
# Table name: mentee_application_states
#
#  id                         :bigint           not null, primary key
#  note                       :text
#  status                     :integer          default("pending"), not null
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
    context 'when the status is pending' do
      let(:status) { :pending }

      it 'returns the next status' do
        expect(described_class.next(status:)).to eq('stage_one')
      end
    end

    context 'when the status is stage_one' do
      let(:status) { :stage_one }

      it 'returns the next status' do
        expect(described_class.next(status:)).to eq('stage_two')
      end
    end

    context 'when the status is stage_two' do
      let(:status) { :stage_two }

      it 'returns the next status' do
        expect(described_class.next(status:)).to eq('stage_three')
      end
    end

    context 'when the status is stage_three' do
      let(:status) { :stage_three }

      it 'returns the next status' do
        expect(described_class.next(status:)).to eq('stage_four')
      end
    end

    context 'when the status is stage_four' do
      let(:status) { :stage_four }

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
