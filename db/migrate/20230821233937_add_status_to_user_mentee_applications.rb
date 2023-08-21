class AddStatusToUserMenteeApplications < ActiveRecord::Migration[7.0]
  def change
    add_column :user_mentee_applications, :status, :integer
  end
end
