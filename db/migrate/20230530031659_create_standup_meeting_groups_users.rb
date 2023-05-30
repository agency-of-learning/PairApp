class CreateStandupMeetingGroupsUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :standup_meeting_groups_users do |t|
      t.references :standup_meeting_group, null: false, index: false
      t.references :user, null: false, index: false

      t.index [:standup_meeting_group_id, :user_id], name: 'index_smg_users_on_smg_id_and_user_id'
      t.index [:user_id, :standup_meeting_group_id], name: 'index_smg_users_on_user_id_and_smg_id'
      t.timestamps
    end
  end
end
