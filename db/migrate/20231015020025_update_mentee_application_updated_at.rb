class UpdateMenteeApplicationUpdatedAt < ActiveRecord::Migration[7.0]
  def up
    UserMenteeApplication.all.each do |application|
      new_updated_at = application.current_state.updated_at
      application.update!(updated_at: new_updated_at)
    end
  end

  def down
    UserMenteeApplication.update_all('updated_at = created_at')
  end
end
