class RemoveUnnededAttributesFromStandupMeetings < ActiveRecord::Migration[7.0]
  def change
    remove_column :standup_meetings, :today_work_description, :text
    remove_column :standup_meetings, :yesterday_work_description, :text
    remove_column :standup_meetings, :blockers_description, :text
  end
end
