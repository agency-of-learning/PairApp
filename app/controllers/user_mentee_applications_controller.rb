class UserMenteeApplicationsController < ApplicationController
  include ActiveStorage::SetCurrent
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

  # rubocop:disable Metrics/AbcSize
  def create
    if current_user.mentee_application.present?
      redirect_to user_mentee_application_path(current_user.mentee_application)
    end

    @user_mentee_application = authorize UserMenteeApplication.new(
      user: current_user,
      user_mentee_application_cohort: UserMenteeApplicationCohort.active,
      **user_mentee_application_params
    )
    ActiveRecord::Base.transaction do
      @user_mentee_application.save!
      if resume_params[:resume].present?
        current_user.resumes.create!(resume: resume_params[:resume], name: resume_params[:resume_name], current: true)
      end
    end
    redirect_to @user_mentee_application, notice: 'Application succesfully submitted'
  rescue StandardError
    flash.now[:form_errors] = @user_mentee_application.errors.full_messages
    render :new, status: :unprocessable_entity
  end
  # rubocop:enable Metrics/AbcSize

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

  def resume_params
    params.require(:user_mentee_application).permit(:resume, :resume_name)
  end
end
