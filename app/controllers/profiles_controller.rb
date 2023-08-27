class ProfilesController < ApplicationController
  before_action :find_profile, only: %i[show edit update]

  def show; end

  def edit
    @profile_form = ProfileForm.new(profile: @profile, user: current_user)
  end

  def update
    @profile_form = ProfileForm.new(profile: @profile, user: current_user, params: profile_params)

    respond_to do |format|
      if @profile_form.valid? && Profiles::Update.new(form: @profile_form).call! == :ok
        flash.now[:notice] = 'Profile successfully updated!'
        format.html { redirect_to @profile, success: 'Profile successfully updated!' }
      else
        flash.now[:form_errors] = @profile_form.errors.full_messages
        format.html { render :edit, status: :unprocessable_entity }
      end
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
      :resume,
      :resume_name,
      :current_resume_id,
      work_model_preferences: []
    )
  end
end
