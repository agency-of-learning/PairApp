class StandupMeetingPolicy < ApplicationPolicy
  alias_method :standup_meeting, :record

  def index?
    user.admin? || matching_user?
  end

  def update?
    matching_user?
  end

  private

  def matching_user?
    standup_meeting.user_id == user.id
  end

  class Scope < Scope
    def resolve
      user.standup_meetings
    end
  end
end
