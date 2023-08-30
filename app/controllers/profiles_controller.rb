class ProfilesController < ApplicationController
  before_action :find_profile, only: %i[show edit update]

  def show; end

  def edit; end

  def update
    update_records = ActiveRecord::Base.transaction do
      @profile.update!(profile_params)
      Resumes::Update.new(user: current_user, params: resume_params).call!
    end
    if update_records
      redirect_to @profile, success: 'Profile successfully updated!'
    else
      # using this now misses validations and errors on the resume part of the form.
      flash.now[:form_errors] = @profile.errors.full_messages
      render :edit, status: :unprocessable_entity
    end
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
