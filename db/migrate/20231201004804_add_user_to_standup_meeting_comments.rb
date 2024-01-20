class AddUserToStandupMeetingComments < ActiveRecord::Migration[7.0]
  def change
    add_reference :standup_meeting_comments, :user, null: false, foreign_key: true
  end
end
