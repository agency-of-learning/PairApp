# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Navigation::ContainerComponent, type: :component do
  let(:component) { described_class.new(home_path: root_path) }

  before do
    render_inline(component)
  end

  it 'renders a link to the passed in home path' do
    expect(page).to have_link('Agency of Learning', href: root_path)
  end

  context 'when a profile picture slot is passed in' do
    let(:component) do
      described_class.new(home_path: root_path).tap do |c|
        c.with_profile_picture { 'Test Example' }
      end
    end

    it 'renders the passed in content' do
      expect(page).to have_content('Test Example')
    end

    it 'does not render a login link' do
      expect(page).not_to have_link('Login', href: new_user_session_path)
    end
  end

  context 'when a profile picture slot is not passed in' do
    it 'renders a login link' do
      expect(page).to have_link('Login', href: new_user_session_path)
    end
  end
end
