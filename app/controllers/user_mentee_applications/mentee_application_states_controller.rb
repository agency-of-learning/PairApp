class UserMenteeApplications::MenteeApplicationStatesController < ApplicationController
  before_action :load_user_mentee_application
  before_action -> { authorize :user_only, :application_reviewer? }

  def new; end

  # rubocop:disable Metrics/AbcSize
  def create
    respond_to do |format|
      MenteeApplicationTransitionService.call(
        application: @user_mentee_application,
        reviewer: current_user,
        action: application_state_params[:reviewer_action].to_sym,
        note: application_state_params[:note]
      )
      @user_mentee_application.reload
      format.html { redirect_to user_mentee_applications_path }
      format.turbo_stream do
        flash.now[:notice] = "Application updated to #{@user_mentee_application.current_state.status.humanize.downcase}"
      end
    rescue MenteeApplicationTransitionService::InvalidTransitionError => e
      format.html do
        redirect_to new_user_mentee_applications_mentee_application_state_path(@user_mentee_application),
          alert: e.message
      end
      format.turbo_stream { flash.now[:alert] = e.message }
    end
  end
  # rubocop:enable Metrics/AbcSize

  private

  def load_user_mentee_application
    @user_mentee_application = UserMenteeApplication.find(params[:user_mentee_application_id])
  end

  def application_state_params
    params
      .permit(:reviewer_action, :note)
      .merge(status_changed_id: current_user.id)
  end
end
