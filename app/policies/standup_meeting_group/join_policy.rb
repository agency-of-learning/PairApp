class StandupMeetingGroup::JoinPolicy < ApplicationPolicy
  alias_method :standup_meeting_group_user, :record

  def create?
    true
  end

  def destroy?
    true
  end
end
