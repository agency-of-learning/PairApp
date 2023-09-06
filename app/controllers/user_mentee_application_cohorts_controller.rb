class UserMenteeApplicationCohortsController < ApplicationController
  def index
    @active_cohort = UserMenteeApplicationCohort.active
    @inactive_cohorts = UserMenteeApplicationCohort.inactive
  end
end
