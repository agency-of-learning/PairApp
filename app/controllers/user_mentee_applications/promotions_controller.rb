class UserMenteeApplications::PromotionsController < ApplicationController
  def create 
    @user_mentee_application = UserMenteeApplication.find(params[:user_mentee_application_id])
    @mentee_application_state = @user_mentee_application.mentee_application_states.new(status: "Nexted", status_changed_by_id: current_user.id)


   if @mentee_application_state.save
    # @mentee_application_state.status = "Nexted"
    redirect_to user_mentee_applications_path, notice: 'Successfully promoted.'
   else
    render some_error_path, alert: 'Failed to promote.'
   end
  end
end