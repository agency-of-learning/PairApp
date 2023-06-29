# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FlashComponent, type: :component do
  context 'with an alert type message' do
    it 'renders the message with an alert-error class' do
      render_inline(described_class.new(type: :alert, message: 'This is an alert'))

      expect(page).to have_content('This is an alert')
      expect(page).to have_css('.alert-error')
    end
  end

  context 'with a notice type message' do
    it 'renders the message with a alert-success class' do
      render_inline(described_class.new(type: :notice, message: 'This is a notice'))

      expect(page).to have_content('This is a notice')
      expect(page).to have_css('.alert-success')
    end
  end

  context 'with a form_errors types message' do
    it 'renders the messages with an alert-error class' do
      messages = ['form error 1', 'form error 2']
      render_inline(described_class.new(type: :form_errors, message: messages))

      expect(page).to have_content('Error! Please fix inputs')
      expect(page).to have_content('form error 1')
      expect(page).to have_content('form error 2')
      expect(page).to have_css('.alert-error')
    end
  end
end
