# frozen_string_literal: true

class Profiles::PictureComponent < ViewComponent::Base
  include ProfilesHelper

  def initialize(profile:)
    @profile = profile
  end

  private

  attr_reader :profile
end
