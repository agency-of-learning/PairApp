class RemoveStatusFromUserMenteeApplication < ActiveRecord::Migration[7.0]
  def change
    remove_column :user_mentee_applications, :status, :integer
  end
end
