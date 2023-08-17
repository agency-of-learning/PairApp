class ProfilesController < ApplicationController
  before_action :find_profile, except: %i[show]

  def show
    @profile = Profile.includes(:user, :picture_blob).friendly.find(params[:id])
  end

  def edit; end

  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to @profile, success: 'Profile successfully updated!' }
        format.turbo_stream { flash.now[:notice] = 'Profile successfully updated!' }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.turbo_stream { flash.now[:form_errors] = @profile.errors.full_messages }
      end
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
      work_model_preferences: []
    )
  end
end
