# frozen_string_literal: true

class UserMenteeApplication::ActionButtonBuilderComponent < ViewComponent::Base
  attr_reader :mentee_application

  def initialize(mentee_application:)
    @mentee_application = mentee_application
  end

  def call
    link_to(
      'Action',
      new_user_mentee_application_mentee_application_state_path(@mentee_application),
      class: 'link link-primary',
      data: { turbo_frame: 'modal' }
    )
  end
end
