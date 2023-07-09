class StandupMeetingGroupDecorator < SimpleDelegator
  def next_standup_meeting(meeting_date:, date_options:)
    date_options.select { |date| date > meeting_date }.min
  end

  def previous_standup_meeting(meeting_date:, date_options:)
    date_options.select { |date| date < meeting_date }.max
  end
end
