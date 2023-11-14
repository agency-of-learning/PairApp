class MakeIndexesUniqueForStandupMeetingGroupUsers < ActiveRecord::Migration[7.0]
  def change
    change_table :standup_meeting_groups_users do |t|
      # Keep the old indexes until new ones are added for safety.
      t.rename_index :index_smg_users_on_smg_id_and_user_id,
        :index_smg_users_on_smg_id_and_user_id_temp
      t.rename_index :index_smg_users_on_user_id_and_smg_id,
        :index_smg_users_on_user_id_and_smg_id_temp

      t.index [:standup_meeting_group_id, :user_id],
        unique: true,
        name: :index_smg_users_on_smg_id_and_user_id
      t.index [:user_id, :standup_meeting_group_id],
        unique: true,
        name: :index_smg_users_on_user_id_and_smg_id

      t.remove_index name: :index_smg_users_on_smg_id_and_user_id_temp
      t.remove_index name: :index_smg_users_on_user_id_and_smg_id_temp
    end
  end
end
