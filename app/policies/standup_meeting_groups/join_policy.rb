module StandupMeetingGroups
  class JoinPolicy < ApplicationPolicy
    alias_method :standup_meeting_group_user, :record

    def create?
      true
    end

    def destroy?
      user.admin? || record.user == user
    end
  end
end
