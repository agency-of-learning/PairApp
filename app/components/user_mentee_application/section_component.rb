# frozen_string_literal: true

class UserMenteeApplication::SectionComponent < ViewComponent::Base
  def initialize(header_text:)
    @header_text = header_text
  end

  private

  attr_reader :header_text
end
