# frozen_string_literal: true

class UserMenteeApplications::ListItemComponent < ViewComponent::Base
  def initialize(mentee_application:)
    @mentee_application = mentee_application
  end

  private

  attr_reader :mentee_application

  def link_text
    application_cohort = mentee_application.user_mentee_application_cohort

    "Application for #{application_cohort.name}"
  end
end
