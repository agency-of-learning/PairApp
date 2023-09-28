# Preview all emails at http://localhost:3000/rails/mailers/standup_meeting_mailer
class StandupMeetingMailerPreview < ActionMailer::Preview
  def notify_member_of_daily_meeting
    standup_meeting_group = StandupMeetingGroup.last
    user = standup_meeting_group.users.last
    standup_meeting = StandupMeeting.includes(:user).find_or_initialize_by(
      standup_meeting_group:, user:, meeting_date: Date.current
    )
    StandupMeetingMailer.with(recipient: user, standup_meeting:).notify_member_of_daily_meeting
  end
end
