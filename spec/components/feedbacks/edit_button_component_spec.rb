# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Feedbacks::EditButtonComponent, type: :component do
  let!(:current_user) { create(:user) }
  let!(:editable_feedback) { create(:feedback, author: current_user) }
  let(:locked_feedback) { create(:feedback, author: current_user, locked_at: Time.current) }

  context 'when the feedback can be edited' do
    it 'renders an edit link' do
      render_inline(described_class.new(feedback: editable_feedback, current_user:))

      expect(page).to have_link('Edit')
    end
  end

  context 'when the feedback is passed a link style' do
    it 'renders an edit link with a link styling' do
      render_inline(described_class.new(feedback: editable_feedback, current_user:, style: :link))

      expect(page).to have_link('Edit', class: 'btn-link')
    end
  end

  context 'when the feedback is locked' do
    it 'renders nothing' do
      render_inline(described_class.new(feedback: locked_feedback, current_user:))

      expect(page).not_to have_selector('body')
    end
  end
end
