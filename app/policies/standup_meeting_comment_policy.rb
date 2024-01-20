class StandupMeetingCommentPolicy < ApplicationPolicy
  alias_method :standup_meeting_comment, :record

  def destroy?
    user == standup_meeting_comment.user
  end

  def edit?
    user == standup_meeting_comment.user
  end
end
