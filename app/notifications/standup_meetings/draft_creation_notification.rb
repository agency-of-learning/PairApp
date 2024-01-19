module StandupMeetings
  class DraftCreationNotification < Noticed::Base
    deliver_by :database
    deliver_by :email,
      mailer: 'StandupMeetingMailer',
      method: :notify_member_of_daily_meeting

    param :standup_meeting
  end
end
