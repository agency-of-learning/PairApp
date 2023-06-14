class StandupMeetingGroupPolicy < ApplicationPolicy
  alias_method :standup_meeting_group, :record

  def show?
    return true if user.admin?
    # NOTE: Might need to think of a way to optimize this later on.
    user.member? && user.standup_meeting_groups.exists?(id: standup_meeting_group.id)
  end

  def create?
    user.admin?
  end

  def edit?
    user.admin?
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin?
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        user.standup_meeting_groups
      end
    end
  end
end
