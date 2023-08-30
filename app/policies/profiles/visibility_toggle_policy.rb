class Profiles::VisibilityTogglePolicy < ApplicationPolicy
  alias_method :profile, :record

  def create?
    user.id == profile.user_id
  end
end
