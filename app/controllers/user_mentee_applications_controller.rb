class UserMenteeApplicationsController < ApplicationController
  before_action :set_user_mentee_application, only: %i[show]

  def index
    @user_mentee_application = authorize UserMenteeApplication.all
  end

  def show
    authorize @user_mentee_application
  end

  def new
    if current_user.mentee_application.present?
      redirect_to user_mentee_application_path(current_user.mentee_application)
    else
      @user_mentee_application = UserMenteeApplication.new
    end
  end

  def create
    if current_user.mentee_application.present?
      redirect_to user_mentee_application_path(current_user.mentee_application)
    end

    @user_mentee_application = UserMenteeApplication.new(user_mentee_application_params)
    @user_mentee_application.user = current_user
    @user_mentee_application.mentee_application_states.build(status: :pending)
      
    authorize @user_mentee_application

    respond_to do |format|
      if @user_mentee_application.save
        format.html { redirect_to @user_mentee_application, notice: 'Application succesfully submitted' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update; end

  private

  def set_user_mentee_application
    @user_mentee_application = UserMenteeApplication.find(params[:id])
  end

  def user_mentee_application_params
    params.require(:user_mentee_application).permit(
      :additional_information, :available_hours_per_week, :city,
      :country, :github_url, :learned_to_code, :linkedin_url,
      :project_experience, :reason_for_applying, :referral_source, :state
    )
  end
end
