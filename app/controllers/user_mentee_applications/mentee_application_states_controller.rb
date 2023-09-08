class UserMenteeApplications::MenteeApplicationStatesController < ApplicationController
  before_action :load_user_mentee_application

  def new
    @mentee_application_state = @user_mentee_application.mentee_application_states.build
  end

  def create
    @mentee_application_state = @user_mentee_application
                                .mentee_application_states
                                .build(mentee_application_state_params)

    respond_to do |format|
      if @mentee_application_state.save
        format.html { redirect_to user_mentee_applications_path }
        format.turbo_stream { flash.now[:notice] = "Application updated to #{@mentee_application_state.status}" }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  def load_user_mentee_application
    @user_mentee_application = UserMenteeApplication.find(params[:user_mentee_application_id])
  end

  def mentee_application_state_params
    params
      .require(:mentee_application_state)
      .permit(:status, :note)
      .merge(status_changed_id: current_user.id)
  end
end
