class ProfilePolicy < ApplicationPolicy
  alias_method :profile, :record

  def show?
    true
  end

  def update?
    user == profile.user
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
