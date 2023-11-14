class ReplaceStandupMeetingGroupUserIndexesWithNewUniqueOnes < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  # The indexes are temporarily being renamed to be kept only until new unique
  # indexes are created as replacements.
  def up
    change_table :standup_meeting_groups_users do |t|
      ActiveRecord::Base.transaction do
        t.rename_index :index_smg_users_on_smg_id_and_user_id,
          :index_smg_users_on_smg_id_and_user_id_temp
        t.rename_index :index_smg_users_on_user_id_and_smg_id,
          :index_smg_users_on_user_id_and_smg_id_temp
      end

      t.index [:standup_meeting_group_id, :user_id],
        unique: true,
        name: :index_smg_users_on_smg_id_and_user_id,
        algorithm: :concurrently
      t.index [:user_id, :standup_meeting_group_id],
        unique: true,
        name: :index_smg_users_on_user_id_and_smg_id,
        algorithm: :concurrently

      ActiveRecord::Base.transaction do
        t.remove_index name: :index_smg_users_on_smg_id_and_user_id_temp
        t.remove_index name: :index_smg_users_on_user_id_and_smg_id_temp
      end
    end
  end

  def down
    change_table :standup_meeting_groups_user do |t|
      t.index [:user_id, :standup_meeting_group_id],
        name: :index_smg_users_on_user_id_and_smg_id_temp,
        algorithm: :concurrently
      t.index [:standup_meeting_group_id, :user_id],
        name: :index_smg_users_on_smg_id_and_user_id_temp,
        algorithm: :concurrently
    
      ActiveRecord::Base.transaction do
        t.remove_index name: :index_smg_users_on_user_id_and_smg_id
        t.remove_index name: :index_smg_users_on_smg_id_and_user_id

        t.rename_index :index_smg_users_on_smg_id_and_user_id_temp,
          :index_smg_users_on_smg_id_and_user_id
        t.rename_index :index_smg_users_on_user_id_and_smg_id_temp,
          :index_smg_users_on_user_id_and_smg_id
      end
    end
  end
end
