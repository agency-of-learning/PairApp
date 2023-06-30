module StandupMeetingsHelper
  def yesterday(date)
    return date - 1.day if date.is_a? Date
    Date.parse(date) - 1.day
  end

  def tomorrow(date)
    return date + 1.day if date.is_a? Date
    Date.parse(date) + 1.day
  end
end
