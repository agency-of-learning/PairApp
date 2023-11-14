namespace :standup_meeting_group_user d
  desc 'Remove duplicate standup meeting group users' do

  task remove_duplicate_records: :environment  do
    # Remove duplicate records.
    unique_ids = StandupMeetingGroupUser.group(
      :standup_meeting_group_id, :user_id
    ).pluck('MIN(id)')

    StandupMeetingGroupUser.where.not(id: unique_ids).delete_all
  end
end
