# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TableCellComponent, type: :component do
  context 'when passed a link' do
    it 'renders the container wrapped in an anchor tag with href pointing to link' do
      render_inline(described_class.new(container_link: '/link').with_content('Test Cell'))

      expect(page).to have_link('Test Cell', href: '/link')
    end
  end

  context 'when called with no args' do
    it 'renders the container wrapped in a div' do
      render_inline(described_class.new.with_content('Test Cell'))

      expect(page).to have_selector('div', text: 'Test Cell')
    end
  end
end
