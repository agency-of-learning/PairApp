class StandupMeeting::DraftCreationNotification < Noticed::Base
  deliver_by :database
  deliver_by :email,
    mailer: 'StandupMeetingMailer',
    method: :notify_for_draft_create

  param :standup_meeting
end
