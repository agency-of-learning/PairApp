class UserMenteeApplications::MenteeApplicationStatesController < ApplicationController
  def create
    @user_mentee_application = UserMenteeApplication.find(params[:user_mentee_application_id])

    @user_mentee_application.mentee_application_states.create!(
      mentee_application_state_params.merge({ status_changed_id: current_user.id })
    )

    redirect_to user_mentee_applications_path, notice: "Application updated to #{@user_mentee_application.current_status}"
  end

  private

  def mentee_application_state_params
    params.require(:mentee_application_state).permit(:status, :note)
  end
end
