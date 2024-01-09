# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Profiles::VisibilityToggleComponent, type: :component do
  let(:profile) { build(:profile, visibility:) }

  before do
    render_inline(described_class.new(profile:))
  end

  context 'when the profile is public' do
    let(:visibility) { :public }

    it "renders with the app's primary color" do
      expect(page).to have_css('.bg-primary')
    end

    it "renders with the content 'Click Here to make it private'" do
      expect(page).to have_content('Click Here to make it private')
    end

    it 'renders with the unlocked lock icon' do
      expect(page).to have_css('.fa-lock-open')
    end
  end

  context 'when the profile is private' do
    let(:visibility) { :private }

    it 'renders with the error color' do
      expect(page).to have_css('.bg-error')
    end

    it "renders with the content 'Click Here to make it public'" do
      expect(page).to have_content('Click Here to make it public')
    end

    it 'renders with the locked lock icon' do
      expect(page).to have_css('.fa-lock')
    end
  end
end
