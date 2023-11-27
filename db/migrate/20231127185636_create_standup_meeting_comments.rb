class CreateStandupMeetingComments < ActiveRecord::Migration[7.0]
  def change
    create_table :standup_meeting_comments do |t|
      t.string :name
      t.references :standup_meeting, null: false, foreign_key: true

      t.timestamps
    end
  end
end
