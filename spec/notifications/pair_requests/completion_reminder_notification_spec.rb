# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PairRequests::CompletionReminderNotification, type: :notifier do
  include ActiveJob::TestHelper

  let(:pair_request) { create(:pair_request) }

  describe 'deliver notification of accepted pair request' do
    subject(:notification) { described_class.with(pair_request:) }

    before do
      pair_request.status = :accepted
      notification.deliver(pair_request.author)
    end

    after do
      clear_enqueued_jobs
    end

    it 'persists the notification in the database' do
      expect(Notification.count).to eq(1)
    end

    it 'is delivered via email' do
      expect(enqueued_jobs.size).to eq(1)
    end
  end
end
