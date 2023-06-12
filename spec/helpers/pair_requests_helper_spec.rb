require 'rails_helper'

RSpec.describe PairRequestsHelper do
  let(:pair_request) { build(:pair_request, when: when_date, duration:) }

  describe '#format_request_date' do
    context 'when the date is June 10, 2023 at 11:40am' do
      let(:when_date) { DateTime.parse('2023-06-10T11:40:00+00:00') }
      let(:duration) { 30.minutes }

      it 'outputs in the expected format' do
        expected_output = '<span>June 10, 2023</span><br><span>11:40am - 12:10pm</span>'
        expect(format_request_date(pair_request)).to eq(expected_output)
      end
    end

    context 'when the date is August 1, 2023 at 3:12pm' do
      let(:when_date) { DateTime.parse('2023-08-01T15:12:00+00:00') }
      let(:duration) { 60.minutes }

      it 'outputs in the expected format' do
        expected_output = '<span>August 1, 2023</span><br><span>3:12pm - 4:12pm</span>'
        expect(format_request_date(pair_request)).to eq(expected_output)
      end
    end
  end
end
