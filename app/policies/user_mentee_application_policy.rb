class UserMenteeApplicationPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def show?
    user.admin? || matching_user?
  end

  def new?
    matching_user?
  end

  def create?
    true
  end

  def update?
    matching_user?
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(user_id: user.id)
      end
    end
  end

  private

  def matching_user?
    record.user_id == user.id
  end
end
