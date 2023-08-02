# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Profile::PictureComponent, type: :component do
  let(:profile) { build(:profile, job_search_status:) }
  let(:profile_with_picture) { build(:profile, attached_picture: true) }
  let(:job_search_status) { :not_job_searching }

  context 'when the profile does not have an attached image' do
    it 'renders the placeholder profile picture' do
      render_inline(described_class.new(profile:))

      expect(page).to have_css("img[src*='placeholder_profile_picture']")
    end
  end

  context 'when the profile has an attached image' do
    it 'renders an image with the attached file src' do
      render_inline(described_class.new(profile: profile_with_picture))

      attachment_filename = profile_with_picture.picture.filename
      expect(page).to have_css("img[src*='#{attachment_filename}']")
    end
  end

  context 'when the profile indicates the user is not job searching' do
    it 'renders the caption with red colors' do
      render_inline(described_class.new(profile:))

      figcaption = page.find('figcaption')
      expect(figcaption[:class]).to include('red')
    end
  end

  context 'when the profile indicates the user is open to opportunities' do
    let(:job_search_status) { :open_to_opportunities }

    it 'renders the caption with amber colors' do
      render_inline(described_class.new(profile:))

      figcaption = page.find('figcaption')
      expect(figcaption[:class]).to include('amber')
    end
  end

  context 'when the profile indicates the user is open to work' do
    let(:job_search_status) { :open_to_work }

    it 'renders the caption with green colors' do
      render_inline(described_class.new(profile:))

      figcaption = page.find('figcaption')
      expect(figcaption[:class]).to include('green')
    end
  end
end
