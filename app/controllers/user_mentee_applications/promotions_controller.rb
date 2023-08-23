class UserMenteeApplications::PromotionsController < ApplicationController


  def create 
    @user_mentee_application = UserMenteeApplication.find(params[:user_mentee_application_id])
    @mentee_application_state = @user_mentee_application.mentee_application_state.new(mentee_application_state_params)
  end


  private

  def mentee_application_state_params
    params.require(:mentee_application_state).permit(:status, :notes, :user_id, :user_mentee_application_id, :status_changed_by_id)
  end
  
end
