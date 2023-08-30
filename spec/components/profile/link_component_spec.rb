# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Profile::LinkComponent, type: :component do
  context 'when the profile does not have a link for the given type' do
    let(:profile_without_links) { build(:profile) }

    it 'renders nothing' do
      render_inline(described_class.new(link_type: :github_link, profile: profile_without_links))

      expect(page).not_to have_selector('body')
    end
  end

  context 'when the profile has links' do
    let(:profile_with_links) { build(:profile, :with_links) }

    it 'renders the github link and icon when passed the github link type' do
      render_inline(described_class.new(link_type: :github_link, profile: profile_with_links))

      expect(page).to have_link(href: profile_with_links.github_link)
      expect(page).to have_css('.fa-github')
    end

    it 'renders the linkedin link and icon when passed the linkedin link type' do
      render_inline(described_class.new(link_type: :linked_in_link, profile: profile_with_links))

      expect(page).to have_link(href: profile_with_links.linked_in_link)
      expect(page).to have_css('.fa-linkedin-in')
    end

    it 'renders the personal site link and link icon when passed the personal site link type' do
      render_inline(described_class.new(link_type: :personal_site_link, profile: profile_with_links))

      expect(page).to have_link(href: profile_with_links.personal_site_link)
      expect(page).to have_css('.fa-link')
    end

    it 'renders the twitter link and icon when passed the twitter link type' do
      render_inline(described_class.new(link_type: :twitter_link, profile: profile_with_links))

      expect(page).to have_link(href: profile_with_links.twitter_link)
      expect(page).to have_css('.fa-twitter')
    end
  end
end
