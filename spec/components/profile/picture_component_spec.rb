# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Profile::PictureComponent, type: :component do
  let(:profile) { build(:profile, job_search_status:) }
  let(:profile_with_picture) { build(:profile, picture: true) }
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
end
