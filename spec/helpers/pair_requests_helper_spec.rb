require 'rails_helper'

RSpec.describe PairRequestsHelper do
  let(:pair_request) { build(:pair_request, when: when_date, duration:) }
  let(:when_date) { Date.tomorrow }

  describe '#format_request_date' do
    context 'when the date is June 10, 2023 at 11:40am' do
      let(:when_date) { DateTime.parse('2023-06-10T11:40:00+00:00') }
      let(:duration) { 30.minutes }

      it 'outputs in the expected format' do
        expected_output = '<p>June 10, 2023</p><p>11:40am - 12:10pm</p>'
        expect(format_request_date(pair_request)).to eq(expected_output)
      end
    end

    context 'when the date is August 1, 2023 at 3:12pm' do
      let(:when_date) { DateTime.parse('2023-08-01T15:12:00+00:00') }
      let(:duration) { 60.minutes }

      it 'outputs in the expected format' do
        expected_output = '<p>August 1, 2023</p><p>3:12pm - 4:12pm</p>'
        expect(format_request_date(pair_request)).to eq(expected_output)
      end
    end
  end

  describe '#format_duration_minutes' do
    context 'when the duration is 15 minutes' do
      let(:duration) { 15.minutes }

      it "outputs '15 minutes'" do
        expect(format_duration_minutes(pair_request)).to eq('15 minutes')
      end
    end

    context 'when the duration is 90 minutes' do
      let(:duration) { 90.minutes }

      it "outputs '90 minutes'" do
        expect(format_duration_minutes(pair_request)).to eq('90 minutes')
      end
    end
  end
end
