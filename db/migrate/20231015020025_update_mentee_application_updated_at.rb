class UpdateMenteeApplicationUpdatedAt < ActiveRecord::Migration[7.0]
  def up
    UserMenteeApplication.all.each do |application|
      new_updated_at = application.current_state.updated_at
      application.update!(updated_at: new_updated_at)
    rescue StandardError
      # We have some applications that have invalid data (most likely from migration and some pre validation stuff)
      nil
    end
  end

  def down
    UserMenteeApplication.update_all('updated_at = created_at')
  end
end
