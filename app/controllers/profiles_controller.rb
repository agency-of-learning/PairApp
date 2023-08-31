class ProfilesController < ApplicationController
  before_action :find_profile, only: %i[show edit update]

  def show
    @profile = authorize Profile.includes(:user, :picture_blob).friendly.find(params[:id])
  end

  def edit; end

  def update
    ActiveRecord::Base.transaction do
      @profile.update!(profile_params)
      Resumes::UpdateService.new(user: current_user, params: resume_params).call!
    end
    redirect_to @profile, success: 'Profile successfully updated!'
  rescue StandardError
    flash.now[:form_errors] = @profile.errors.full_messages
    render :edit, status: :unprocessable_entity
  end

  private

  def find_profile
    @profile = authorize Profile.includes(:picture_blob, user: :resumes).friendly.find(params[:id])
  end

  def profile_params
    params.require(:profile).permit(
      :picture,
      :location,
      :job_title,
      :bio,
      :slug,
      :job_search_status,
      :github_link,
      :linked_in_link,
      :personal_site_link,
      :twitter_link,
      work_model_preferences: []
    )
  end

  def resume_params
    params.require(:profile).permit(:resume, :resume_name, :current_resume_id)
  end
end
