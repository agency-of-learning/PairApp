module StandupMeetings
  class AutoMissedMeetingWorker < ApplicationWorker
    sidekiq_options queue: 'low'

    # rubocop:disable Rails/SkipsModelValidations
    def perform
      StandupMeeting
        .draft
        .where(meeting_date: ...1.week.ago)
        .update_all(status: :missed)
    end
    # rubocop:enable Rails/SkipsModelValidations
  end
end

StandupMeeting::AutoMissedMeetingWorker = StandupMeetings::AutoMissedMeetingWorker
