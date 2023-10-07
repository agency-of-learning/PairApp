class UserMenteeApplicationCohortsController < ApplicationController
  before_action -> { authorize :user_only, :application_reviewer? }

  def index
    @active_cohort = UserMenteeApplicationCohort.active
    @inactive_cohorts = UserMenteeApplicationCohort.inactive
  end

  def show
    @cohort = UserMenteeApplicationCohort
              .includes(user_mentee_applications: :mentee_application_states)
              .find(params[:id])

    @filtered_applications = filter_applications(@cohort.user_mentee_applications)
  end

  private

  def filter_applications(applications)
    case params[:filter]
    when 'accepted', 'rejected', 'application_received'
      applications.filter { |application| application.current_status == params[:filter] }
    else
      applications.filter(&:in_review?)
    end
  end
end
