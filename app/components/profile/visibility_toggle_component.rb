# frozen_string_literal: true

class Profile::VisibilityToggleComponent < ViewComponent::Base
  LOCK_ICONS = {
    public: 'fa-solid fa-lock-open',
    private: 'fa-solid fa-lock'
  }.freeze

  def initialize(profile:)
    @profile = profile
  end

  private

  attr_reader :profile

  def toggle_button
    button_to(
      'Here',
      profile_visibility_toggles_path(profile),
      class: 'link inline',
      form_class: 'link inline'
    )
  end

  def container_color
    profile.public_visibility? ? 'bg-primary' : 'bg-error'
  end

  def opposite_state
    profile.public_visibility? ? 'private' : 'public'
  end

  def icon_class_names
    LOCK_ICONS.fetch(profile.visibility.to_sym)
  end
end
