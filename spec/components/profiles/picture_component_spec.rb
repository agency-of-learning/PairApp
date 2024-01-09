# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Profiles::PictureComponent, type: :component do
  let(:profile) { build(:profile, job_search_status:) }

  context 'when the profile is not job searching' do
    let(:job_search_status) { :not_job_searching }

    it 'does not render with the Open to Work svg' do
      render_inline(described_class.new(profile:))

      expect(page).not_to have_selector('svg')
      expect(page).not_to have_content('Open to work')
    end
  end

  context 'when the profile is open to work' do
    let(:job_search_status) { :open_to_work }

    it "renders with the 'Open to Work' svg overlay" do
      render_inline(described_class.new(profile:))

      expect(page).to have_selector('svg')
      expect(page).to have_content('Open to work')
    end
  end
end
