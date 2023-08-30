class Profiles::VisibilityTogglesController < ApplicationController
  def create
    @profile = Profile.friendly.find(params[:profile_id])
    authorize @profile, policy_class: Profiles::VisibilityTogglePolicy
    @profile.toggle_visibility!

    redirect_to @profile
  end
end
