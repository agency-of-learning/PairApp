# == Schema Information
#
# Table name: pair_requests
#
#  id         :bigint           not null, primary key
#  duration   :float            not null
#  status     :integer          default("pending"), not null
#  when       :datetime         not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  author_id  :bigint           not null
#  invitee_id :bigint           not null
#
# Indexes
#
#  index_pair_requests_on_author_id   (author_id)
#  index_pair_requests_on_invitee_id  (invitee_id)
#
# Foreign Keys
#
#  fk_rails_...  (author_id => users.id)
#  fk_rails_...  (invitee_id => users.id)
#

require 'rails_helper'

RSpec.describe PairRequest do
  subject { build(:pair_request, duration:, when: when_date) }

  let(:duration) { 20.minutes }
  let(:when_date) { Date.today + 2.weeks }

  describe '#duration' do
    it 'is valid' do
      expect(subject).to be_valid
    end

    context 'when duration is less than 15 minutes' do
      let(:duration) { 10.minutes }

      it 'is invalid' do
        expect(subject).not_to be_valid
      end
    end
  end

  describe '#when' do
    it 'is valid' do
      expect(subject).to be_valid
    end

    context 'when date is more than a month into the future' do
      let(:when_date) { Date.today + 2.months }

      it 'is invalid' do
        expect(subject).not_to be_valid
      end
    end
  end
end
