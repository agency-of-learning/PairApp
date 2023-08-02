# frozen_string_literal: true

class Profile::PictureComponent < ViewComponent::Base
  JOB_SEARCH_COLOR_CLASSES = {
    'not_job_searching' => 'bg-red-800 text-red-50',
    'open_to_opportunities' => 'bg-amber-800 text-amber-50',
    'open_to_work' => 'bg-green-800 text-green-50'
  }.freeze

  def initialize(profile:)
    @profile = profile
  end

  private

  attr_reader :profile

  def figcaption_colors
    JOB_SEARCH_COLOR_CLASSES.fetch(profile.job_search_status)
  end

  def profile_picture_src
    if profile.picture.attached?
      profile.picture.variant(:square)
    else
      'placeholder_profile_picture.png'
    end
  end
end
