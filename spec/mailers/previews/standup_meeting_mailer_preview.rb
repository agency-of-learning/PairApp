# Preview all emails at http://localhost:3000/rails/mailers/standup_meeting_mailer
class StandupMeetingMailerPreview < ActionMailer::Preview
  def notify_member_of_daily_meeting
    standup_meeting = StandupMeeting.last
    recipient = standup_meeting.user
    StandupMeetingMailer.with(recipient:, standup_meeting:).notify_member_of_daily_meeting
  end
end
