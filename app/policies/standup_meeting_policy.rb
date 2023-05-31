class StandupMeetingPolicy < ApplicationPolicy
  alias_method :standup_meeting, :record

  def index?
    user.admin?
  end

  def show?
    user.admin? || matching_user?
  end

  def create?
    # NOTE: Might need to think of a way to optimize this later on.
    user.standup_meeting_groups.exists?(id: standup_meeting.standup_meeting_group_id)
  end

  def update?
    user.admin? || matching_user?
  end

  def destroy?
    user.admin? || matching_user?
  end

  private

  def matching_user?
    standup_meeting.user_id == user.id
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        user.standup_meetings
      end
    end
  end
end
