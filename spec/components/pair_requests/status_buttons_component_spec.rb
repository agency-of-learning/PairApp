# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PairRequests::StatusButtonsComponent, type: :component do
  let(:invitee) { create(:user) }
  let(:author) { create(:user) }

  context 'when the current user is the invitee' do
    let(:current_user) { invitee }

    context 'with a pair request that can be accepted or rejected' do
      it 'renders an Accept button and a Reject button' do
        pending_request = create(:pair_request, invitee: current_user)
        render_inline(described_class.new(pair_request: pending_request, current_user:))

        expect(page).to have_button('Accept')
        expect(page).to have_button('Reject')
      end
    end

    context 'with a pair request that is accepted' do
      it 'renders the Reject button' do
        accepted_request = create(:pair_request, invitee: current_user, status: :accepted)
        render_inline(described_class.new(pair_request: accepted_request, current_user:))

        expect(page).to have_button('Reject')
      end
    end

    context 'with a pair request that is completed' do
      it 'renders nothing' do
        completed_request = create(:pair_request, invitee: current_user, status: :completed)
        render_inline(described_class.new(pair_request: completed_request, current_user:))

        expect(page).not_to have_selector('body')
      end
    end
  end

  context 'when the current user is the author' do
    let(:current_user) { author }

    context 'with a request that can be completed' do
      it 'renders a Complete button' do
        request_awaiting_completion = create(:pair_request,
          author: current_user,
          when: 5.minutes.ago,
          status: :accepted)

        render_inline(described_class.new(pair_request: request_awaiting_completion, current_user:))
        expect(page).to have_button('Complete')
        expect(page).to have_button('Cancel')
      end
    end

    context 'with a request that is pending' do
      it 'renders a Cancel button' do
        pending_request = create(:pair_request, author: current_user)

        render_inline(described_class.new(pair_request: pending_request, current_user:))
        expect(page).to have_button('Cancel')
      end
    end
  end
end
