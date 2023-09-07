class UserMenteeApplicationCohortsController < ApplicationController
  before_action -> { authorize :user_only, :admin? }

  def index
    @active_cohort = UserMenteeApplicationCohort.active
    @inactive_cohorts = UserMenteeApplicationCohort.inactive
  end

  def show
    @cohort = UserMenteeApplicationCohort
              .includes(:user_mentee_applications)
              .find(params[:id])
  end
end
