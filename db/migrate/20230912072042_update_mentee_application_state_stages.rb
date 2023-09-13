class UpdateMenteeApplicationStateStages < ActiveRecord::Migration[7.0]
  def up
    rejected_applications = MenteeApplicationState.where(status: 6)
    rejected_applications.update_all(status: 7)

    accepted_applications = MenteeApplicationState.where(status: 5)
    accepted_applications.update_all(status: 6)
  end
  
  def down
    accepted_applications = MenteeApplicationState.where(status: 6)
    accepted_applications.update_all(status: 5)

    rejected_applications = MenteeApplicationState.where(status: 7)
    rejected_applications.update_all(status: 6)
  end
end
