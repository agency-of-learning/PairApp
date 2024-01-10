module StandupMeetings
  class CreateDraftWorker < ApplicationWorker
    sidekiq_options queue: 'default'

    def perform(standup_meeting_group_id, user_id, date)
      standup_meeting = StandupMeeting.includes(:user).find_or_initialize_by(
        standup_meeting_group_id:, user_id:, meeting_date: date
      )

      return if standup_meeting.persisted?

      standup_meeting.save!

      user = standup_meeting.user

      StandupMeeting::DraftCreationNotification.with(standup_meeting:).deliver_later(user)
    end
  end
end
