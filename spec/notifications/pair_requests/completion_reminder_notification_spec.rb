# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PairRequests::CompletionReminderNotification, type: :notifier do
  include ActiveJob::TestHelper

  let(:pair_request) { create(:pair_request, status: :accepted) }

  subject(:notification) { described_class.with(pair_request:) }

  after do
    clear_enqueued_jobs
  end

  describe 'deliver notification of accepted pair request' do
    before do
      notification.deliver(pair_request.author)
    end

    it 'persists the notification in the database' do
      expect(Notification.count).to eq(1)
    end

    it 'is delivered via email' do
      expect(enqueued_jobs.size).to eq(1)
    end
  end
end

