class ProfilesController < ApplicationController
  def show
    @profile = Profile.includes(:user, :picture_blob).find(params[:id])
  end

  def edit
    @profile = authorize Profile.find(params[:id])
  end

  def update
    @profile = authorize Profile.find(params[:id])

    if @profile.update(profile_params)
      redirect_to @profile, success: 'Profile successfully updated!'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def profile_params
    params.require(:profile).permit(
      :picture,
      :location,
      :job_title,
      :bio,
      :job_search_status,
      work_model_preferences: []
    )
  end
end