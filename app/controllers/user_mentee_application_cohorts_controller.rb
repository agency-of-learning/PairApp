class UserMenteeApplicationCohortsController < ApplicationController
  before_action -> { authorize :user_only, :admin? }

  def index
    @active_cohort = UserMenteeApplicationCohort.active
    @inactive_cohorts = UserMenteeApplicationCohort.inactive
  end

  def show
    @cohort = UserMenteeApplicationCohort
                .includes(user_mentee_applications: :mentee_application_states)
                .find(params[:id])

    if params[:filter]
      if params[:filter] == 'in_review'
        @filtered_applications = @cohort.user_mentee_applications.select do |application|
          application.in_review?
        end
      else
        @filtered_applications = @cohort.user_mentee_applications.select do |application|
          application.current_status == params[:filter]
        end
      end
    else
      @filtered_applications = @cohort.user_mentee_applications
    end
  end  
end
