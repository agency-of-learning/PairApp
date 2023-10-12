class UserMenteeApplications::WithdrawalsController < ApplicationController
  def create
    @user_mentee_application = UserMenteeApplication.find(params[:user_mentee_application_id])
    authorize :user_only, :application_reviewer?

    MenteeApplicationTransitionService.call(
      application: @user_mentee_application,
      reviewer: current_user,
      action: :withdrawn
    )

    redirect_to @user_mentee_application, notice: 'Application withdrawn'
  end
end
