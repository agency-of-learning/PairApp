class StandupMeetingGroup
  class DetermineMissingStandupMeetingsWorker < ApplicationWorker
    sidekiq_options queue: 'default'

    def perform(start_minutes = 0, end_minutes = 0)
      start_time = start_minutes.minutes.ago
      end_time = end_minutes.minutes.from_now
      current_date = Date.current

      # NOTE: the goal is to compare the number of users in a standup_meeting_group to the number of standup_meetings
      # for a particular day. If there are more users than standup_meetings, it means people haven't completed it yet.
      # Thus, we need to create standup_meetings (drafts) for those users and send a notification.
      standup_meeting_groups =
        StandupMeetingGroup.left_outer_joins(:standup_meetings)
                           .joins(:standup_meeting_groups_users)
                           .preload(:standup_meetings)
                           .select('standup_meeting_groups.id, ARRAY_AGG(standup_meeting_groups_users.user_id) AS user_ids')
                           .where(active: true)
                           .where('standup_meeting_groups.start_time::time BETWEEN ?::time AND ?::time', start_time, end_time)
                           .where('standup_meetings.id IS NULL OR standup_meetings.meeting_date = ?', current_date)
                           .group('standup_meeting_groups.id')
                           .having('COUNT(standup_meeting_groups_users.id) > COUNT(DISTINCT standup_meetings.id)')

      # NOTE: later on if this becomes a bottle neck we can have a separate worker for each standup_meeting_group (and pass in user_ids)
      # ideally though we would just batch these at that point.
      standup_meeting_groups.each do |standup_meeting_group|
        standup_meeting_group.user_ids.each do |user_id|
          StandupMeeting::CreateDraftWorker.perform_async(
            standup_meeting_group.id,
            user_id,
            current_date.to_s
          )
        end
      end
    end
  end
end
