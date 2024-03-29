class Admin::UserMenteeApplicationCohortsController < ApplicationController
  before_action -> { authorize :user_only, :application_reviewer? }

  def index
    @active_cohort = UserMenteeApplicationCohort.active
    @inactive_cohorts = UserMenteeApplicationCohort.inactive
  end

  def show
    @cohort = UserMenteeApplicationCohort
              .includes(user_mentee_applications: :mentee_application_states)
              .find(params[:id])

    @filtered_applications = filter_applications(
      @cohort.user_mentee_applications.order_by_latest_updated
    )
  end

  private

  def filter_applications(applications)
    case params[:filter]
    when 'accepted', 'rejected', 'application_received', 'withdrawn'
      applications.filter { |application| application.current_status == params[:filter] }
    when 'in_review'
      applications.filter(&:in_review?)
    else
      applications.filter { |application| application.current_status == 'application_received' }
    end
  end
end
