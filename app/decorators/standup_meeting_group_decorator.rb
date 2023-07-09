class StandupMeetingGroupDecorator < SimpleDelegator
  attr_reader :meeting_dates

  def initialize(*args)
    super(*args)
    return if nil?
    @meeting_dates = StandupMeeting.meeting_dates(id)
  end

  def next_standup_meeting(date:)
    meeting_dates.select { |meeting_date| meeting_date > date }.min
  end

  def previous_standup_meeting(date:)
    meeting_dates.select { |meeting_date| meeting_date < date }.max
  end
end
