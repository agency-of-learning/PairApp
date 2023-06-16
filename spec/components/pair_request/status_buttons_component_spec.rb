# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PairRequest::StatusButtonsComponent, type: :component do
  let!(:current_user) { create(:user) }
  let!(:pending_request) { create(:pair_request, invitee: current_user) }
  let!(:completed_request) { create(:pair_request, invitee: current_user, status: :completed) }
  let!(:request_awaiting_completion) do
    create(:pair_request, author: current_user, when: 5.minutes.ago, status: :accepted)
  end

  context 'with a pair request that can be accepted or rejected' do
    it 'renders an Accept button and a Reject button' do
      render_inline(described_class.new(pair_request: pending_request, current_user:))

      expect(page).to have_button('Accept')
      expect(page).to have_button('Reject')
    end
  end

  context 'with a pair request that is completed' do
    it 'renders nothing' do
      render_inline(described_class.new(pair_request: completed_request, current_user:))

      expect(page).not_to have_selector('body')
    end
  end

  context 'with a request that can be completed' do
    it 'renders a Complete button' do
      render_inline(described_class.new(pair_request: request_awaiting_completion, current_user:))

      expect(page).to have_button('Complete')
    end
  end
end
