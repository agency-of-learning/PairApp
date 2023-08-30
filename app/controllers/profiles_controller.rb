class ProfilesController < ApplicationController
  before_action :find_profile, except: %i[show]

  def show
    @profile = authorize Profile.includes(:user, :picture_blob).friendly.find(params[:id])
  end

  def edit; end

  def update
    if @profile.update(profile_params)
      redirect_to @profile, success: 'Profile successfully updated!'
    else
      flash.now[:form_errors] = @profile.errors.full_messages
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def find_profile
    @profile = authorize Profile.friendly.find(params[:id])
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
end
