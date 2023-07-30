class ProfilesController < ApplicationController
  def show
    @profile = Profile.find(params[:id])
  end

  def edit
    @profile = Profile.find(params[:id])
  end

  def update
    @profile = Profile.find(params[:id])

    if @profile.update(profile_params)
      redirect_to @profile, success: 'Profile successfully updated!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def profile_params
    params.require(:profile).permit(:picture)
  end
end
