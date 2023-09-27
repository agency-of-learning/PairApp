# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Navigation::GuestComponent, type: :component do
  before do
    render_inline(described_class.new(current_user: nil))
  end

  it 'renders a link to the applications portal' do
    expect(page).to have_link('FAQ', href: faq_path)
  end
end
