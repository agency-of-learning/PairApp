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
require 'rails_helper'

RSpec.describe MenteeApplicationState do
  let(:user) { create(:user) }
  let(:mentee_application) { create(:user_mentee_application) }
  let(:mentee_application_state) { create(:mentee_application_state, user_mentee_application: mentee_application) }

  context 'when status is application received' do
    describe 'future_state' do
      it 'returns the future state as coding challenge sent' do
        expect(mentee_application_state.future_state).to eq(:coding_challenge_sent)
      end
    end

    describe 'next_state' do
      it 'returns the next state as nil' do
        expect(mentee_application_state.next_state).to be_nil
      end
    end

    describe 'previous_state' do
      it 'returns the current state' do
        expect(mentee_application_state.previous_state.status.to_sym).to eq(:application_received)
      end
    end
  end

  context 'when status is coding challenge sent' do
    let(:mentee_application_state) do
      create(:mentee_application_state, :coding_challenge_sent, user_mentee_application: mentee_application)
    end

    describe 'future_state' do
      it 'returns the future state as coding_challenge_received' do
        expect(mentee_application_state.future_state).to eq(:coding_challenge_received)
      end
    end

    describe 'next_state' do
      it 'returns the next state as coding_challenge_completed' do
        expect(mentee_application_state.next_state).to be_nil
      end

      context 'when the user is on application_received state' do
        let(:previous_mentee_application_state) { mentee_application_state.previous_state }

        it 'returns the next state as coding_challenge_sent' do
          expect(previous_mentee_application_state.next_state.status.to_sym).to eq(:coding_challenge_sent)
        end
      end
    end

    describe 'previous_state' do
      it 'returns the previous state as application_received' do
        expect(mentee_application_state.previous_state.status.to_sym).to eq(:application_received)
      end
    end
  end
end
