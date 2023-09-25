# frozen_string_literal: true

class NavigationContainerComponent < ViewComponent::Base
  renders_many :primary_links, ->(text:, path:) { tag.li link_to(text, path) }
  renders_many :dropdown_links, ->(text:, path:, **opts) { tag.li link_to(text, path), **opts }

  renders_one :profile_picture

  renders_one :page_content

  def initialize(home_path:)
    @home_path = home_path
  end

  private

  attr_reader :home_path
  alias_method :render_dropdown?, :profile_picture?
end
