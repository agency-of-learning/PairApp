class UserMenteeApplicationsController < ApplicationController
  include ActiveStorage::SetCurrent
  before_action :set_active_cohort, only: %i[index new create]

  def index
    authorize :user_only, :applicant?
    @user_mentee_applications = current_user
                                .mentee_applications
                                .order_newest_first
                                .includes(
                                  :user_mentee_application_cohort,
                                  :mentee_application_states
                                )

    @user_past_applications = @user_mentee_applications.past
    @most_recent_application = @user_mentee_applications.first
  end

  def show
    @user_mentee_application = authorize UserMenteeApplication.find(params[:id])
  end

  def new
    if @active_cohort.application_for_user?(current_user)
      redirect_to user_mentee_applications_path
    else
      latest_application = current_user.mentee_applications.last
      @user_mentee_application = UserMenteeApplication.new(
        github_url: latest_application&.github_url,
        linkedin_url: latest_application&.linkedin_url,
        referral_source: latest_application&.referral_source,
        city: latest_application&.city,
        state: latest_application&.state,
        country: latest_application&.country,
        learned_to_code: latest_application&.learned_to_code
      )
    end
  end

  # rubocop:disable Metrics/AbcSize
  def create
    redirect_to user_mentee_applications_path if @active_cohort.application_for_user?(current_user)

    @user_mentee_application = authorize current_user.mentee_applications.new(
      user_mentee_application_cohort: @active_cohort,
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

  def set_active_cohort
    @active_cohort = UserMenteeApplicationCohort.active
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
