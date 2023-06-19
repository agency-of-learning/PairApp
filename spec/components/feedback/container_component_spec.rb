# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Feedback::ContainerComponent, type: :component do
  let(:current_user) { create(:user) }
  let(:authored_feedback) { create(:feedback, author: current_user) }
  let(:received_feedback) { create(:feedback, receiver: current_user) }

  context 'when no feedback is passed in' do
    it 'renders nothing' do
      render_inline(described_class.new(feedback: nil, current_user:))

      expect(page).not_to have_selector('body')
    end
  end

  context 'when the user is the author of the feedback' do
    it 'renders text for Given Feedback' do
      render_inline(described_class.new(feedback: authored_feedback, current_user:))

      expect(page).to have_content('Given Feedback')
    end

    it 'renders an edit link' do
      render_inline(described_class.new(feedback: authored_feedback, current_user:))

      expect(page).to have_link('Edit')
    end
  end

  context 'when the user is the receiver of the feedback' do
    it 'renders text for Received Feedback' do
      render_inline(described_class.new(feedback: received_feedback, current_user:))

      expect(page).to have_content('Received Feedback')
    end

    it 'does not render an edit link' do
      render_inline(described_class.new(feedback: received_feedback, current_user:))

      expect(page).not_to have_link('Edit')
    end
  end
end
