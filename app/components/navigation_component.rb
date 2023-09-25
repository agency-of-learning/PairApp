# frozen_string_literal: true

class NavigationComponent < ViewComponent::Base
  include ProfilesHelper

  def self.for(current_user:)
    role = (current_user&.role || 'Guest').capitalize
    subclass = "Navigation::#{role}Component".safe_constantize

    subclass.new(current_user:)
  end

  def initialize(current_user:)
    @user = current_user
  end

  private

  attr_reader :user

  def profile_dropdown_image
    profile_picture_tag user&.profile, variant: :icon, class: 'w-12 h-auto rounded-full'
  end
end
