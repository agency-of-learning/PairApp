class ProfilePolicy < ApplicationPolicy
  alias_method :profile, :record

  def show?
    return true if profile.public_visibility?

    user.present? && (matching_user? || user.admin?)
  end

  def update?
    user == profile.user
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end

  private

  def matching_user?
    profile.user_id == user.id
  end
end
