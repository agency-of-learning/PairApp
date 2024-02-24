class UserMenteeApplications::MenteeApplicationStatesController < ApplicationController
  before_action :load_user_mentee_application
  skip_before_action :only_authorize_agent

  def show
    @state = @user_mentee_application.mentee_application_states.find_by!(status: params[:status_name])
    @previous_state = @state.previous_state
    @next_state = @state.next_state
  end

  private

  def load_user_mentee_application
    @user_mentee_application = current_user.mentee_applications.find(params[:user_mentee_application_id])
  end
end
