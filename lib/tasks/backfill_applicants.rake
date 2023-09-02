require 'csv'
require 'debug'
require "net/http"

def grab_location(location_string)
  return if location_string.nil?
  uri = URI("https://nominatim.openstreetmap.org/search?q=\"#{location_string}\"&format=json&&addressdetails=1&accept-language=en")
  response = Net::HTTP.get_response(uri)
  location_data = JSON.parse(response.body)[0]["address"]
  
  [location_data["city"], location_data["state"], location_data["country"]]
end

task backfill_applicant_responses: :environment do
  headers = ["#","name","email","reason_for_applying","linkedin_url","learned_to_code","location","project_experience","available_hours_per_week","referral_source","additional_information","start_utc","submit_utc","network_id","tags"]
  table = CSV.read(Rails.root.join('lib', 'tasks', 'responses.csv'), headers:,  liberal_parsing: true)
  table.each_with_index do |row, idx|
    next if idx == 0 # skip header row
    first_name, last_name = row['name'].titleize.split(" ")
    email = row['email']

    city, state, country = grab_location(row["location"])
    additional_information = row["additional_information"]&.squish
    reason_for_applying = row["reason_for_applying"]&.squish
    linkedin_url = row["linkedin_url"]
    learned_to_code = row["learned_to_code"]&.squish
    project_experience = row["project_experience"]&.squish
    # extract and coerce hours from string
    available_hours_per_week = row["available_hours_per_week"]&.split(" ")&.find { |el| el.to_i > 0 }&.to_i

    ActiveRecord::Base.transaction do
      user = User.find_or_initialize_by(first_name:, last_name:, email:)
      user.password = SecureRandom.uuid unless user.persisted?
      next unless user.save
      # responses.csv have no github_url
      UserMenteeApplication.create(
        user:,
        city:, 
        state:, 
        country:, 
        additional_information:, 
        reason_for_applying:, 
        linkedin_url:, 
        learned_to_code:, 
        project_experience:, 
        available_hours_per_week:
      )
      puts "processed #{user.first_name} application"
    end
  end

  puts 'Processed responses.csv!'

  table = CSV.read(Rails.root.join('lib', 'tasks', 'dataclips.csv'), headers: true,  liberal_parsing: true)
  table.each_with_index do |row, idx|
    first_name, last_name = [row['first_name'].titleize.squish, row['last_name'].titleize.squish]
    email = row['email']

    city, state, country = grab_location(row["location"])
    additional_information = row["additional_information"]&.squish
    reason_for_applying = row["reason_for_applying"]&.squish
    linkedin_url = row["linkedin_url"]
    learned_to_code = row["learned_to_code"]&.squish
    project_experience = row["project_experience"]&.squish
    # hours/week not asked on dataclips file, so default to 15
    available_hours_per_week = 15

    ActiveRecord::Base.transaction do
      user = User.find_or_initialize_by(first_name:, last_name:, email:)
      user.password = SecureRandom.uuid unless user.persisted?
      next unless user.save
      # responses.csv have no github_url
      UserMenteeApplication.create(
        user:,
        city:, 
        state:, 
        country:, 
        additional_information:, 
        reason_for_applying:, 
        linkedin_url:, 
        learned_to_code:, 
        project_experience:, 
        available_hours_per_week:
      )
      puts "processed #{user.first_name} application"
    end
  end
end