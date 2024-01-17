# frozen_string_literal: true

class Profiles::LinkComponent < ViewComponent::Base
  LINK_ICONS = {
    github_link: 'fa-brands fa-github text-neutral hover:bg-neutral',
    linked_in_link: 'fa-brands fa-linkedin-in text-linkedin-brand hover:bg-linkedin-brand',
    personal_site_link: 'fa-solid fa-link hover:bg-neutral',
    twitter_link: 'fa-brands fa-twitter text-twitter-brand hover:bg-twitter-brand'
  }.freeze

  with_collection_parameter :link_type

  def initialize(profile:, link_type:)
    @profile = profile
    @link_type = link_type
  end

  def call
    link_to url, target: '_blank', rel: 'noopener' do
      icon_tag
    end
  end

  private

  attr_reader :profile, :link_type

  def url
    @url ||= profile.public_send(link_type)
  end

  def render?
    url.present?
  end

  def icon_tag
    icon_class_names = LINK_ICONS.fetch(link_type)
    general_class_names = 'fa-xl rounded-lg w-8 py-1 hover:text-primary-content transition-all'

    tag.span(class: "#{icon_class_names} #{general_class_names}")
  end
end
