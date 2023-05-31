class UpdateStandupMeetingNullables < ActiveRecord::Migration[7.0]
  def change
    change_column_null :standup_meetings, :yesterday_work_description, true
    change_column_null :standup_meetings, :today_work_description, true
  end
end
