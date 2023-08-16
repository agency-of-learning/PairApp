# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserMenteeApplication::SectionComponent, type: :component do
  it 'renders header text for the component' do
    render_inline(described_class.new(header_text: 'I am awesome!'))

    expect(page).to have_content('I am awesome!')
  end
end
