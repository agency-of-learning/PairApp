require 'rails_helper'

RSpec.describe PairRequestsHelper do
  let(:pair_request) { build(:pair_request, when: when_date) }

  describe '#format_date' do
    context 'when the date is June 10, 2023 at 11:40am' do
      let(:when_date) { DateTime.parse('2023-06-10T11:40:00+00:00') }

      it 'outputs in the expected format' do
        expected_output = 'June 10, 2023 11:40am'
        expect(format_date(pair_request)).to eq(expected_output)
      end
    end

    context 'when the date is August 1, 2023 at 3:12pm' do
      let(:when_date) { DateTime.parse('2023-08-01T15:12:00+00:00') }

      it 'outputs in the expected format' do
        expected_output = 'August 1, 2023 3:12pm'
        expect(format_date(pair_request)).to eq(expected_output)
      end
    end
  end
end
