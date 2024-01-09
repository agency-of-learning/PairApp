# frozen_string_literal: true

class UserMenteeApplications::ReapplyCtaComponent < ViewComponent::Base
  def initialize(active_cohort:, last_application:)
    @active_cohort = active_cohort
    @last_application = last_application
  end

  private

  attr_reader :active_cohort, :last_application

  def render?
    active_cohort.present? && application_not_in_cohort?
  end

  def cta_action_text
    last_application.present? ? 'Reapply' : 'Apply'
  end

  def application_not_in_cohort?
    return true if last_application.blank?

    last_application.user_mentee_application_cohort_id != active_cohort.id
  end
end
