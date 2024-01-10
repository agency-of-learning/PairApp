module StandupMeetings
  class CompletionPolicy < ApplicationPolicy
    alias_method :standup_meeting, :record

    def create?
      standup_meeting.user_id == user.id
    end
  end
end
