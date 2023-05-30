class CreateStandupMeetingGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :standup_meeting_groups do |t|
      t.string :name, null: false
      t.boolean :active, default: true, null: false
      t.time :start_time, null: false
      t.integer :frequency, default: 0, null: false

      t.timestamps
    end
  end
end
