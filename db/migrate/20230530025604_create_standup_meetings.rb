class CreateStandupMeetings < ActiveRecord::Migration[7.0]
  def change
    create_table :standup_meetings do |t|
      t.references :standup_meeting_group, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.text :yesterday_work_description, null: false
      t.text :today_work_description, null: false
      t.text :blockers_description, null: false

      t.date :meeting_date, null: false
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end
