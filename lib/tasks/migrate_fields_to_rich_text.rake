namespace :standup_meeting do
  desc 'Migrate standup meeting data to action text'

  task migrate_data_to_action_text: :environment do
    failed_updates = []

    StandupMeeting.where(status: 'completed').find_each do |meeting|
      meeting.update!(
        today_work_description: meeting.read_attribute_before_type_cast(:today_work_description),
        yesterday_work_description: meeting.read_attribute_before_type_cast(:yesterday_work_description),
        blockers_description: meeting.read_attribute_before_type_cast(:blockers_description)
      )
    rescue StandardError => e
      failed_updates << { id: meeting.id, error: e.message }
      Rails.logger.error "Migration failed for StandupMeeting id: #{meeting.id}, error: #{e.message}"
    end

    if failed_updates.any?
      puts "Migration completed with some failures: #{failed_updates.size} failed updates."
      Rails.logger.error "Failed updates: #{failed_updates.inspect}"
    else
      puts 'StandupMeeting data migration to action text is complete.'
    end
  end
end
