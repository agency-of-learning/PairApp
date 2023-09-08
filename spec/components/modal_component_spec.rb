# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ModalComponent, type: :component do
  let(:title) { 'Test title' }

  it 'renders the title' do
    render_inline(described_class.new(title:))

    expect(page).to have_content(title)
  end
end
