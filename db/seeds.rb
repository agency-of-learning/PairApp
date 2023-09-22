require 'faker'

def generate_user_data(role:, idx:)
  raise StandardError, 'Invalid role' unless User.roles.key?(role)
  email = idx.zero? ? "#{role}@aol.com" : "#{role}#{idx}@aol.com"
  { first_name: role.capitalize, last_name: Faker::Name.last_name, email:, password: 'password', role: }
end

def generate_pair_request_data(users:, status:, pair_date: nil)
  author, invitee = users.sample(2)
  pair_date ||= [1, 2, 3, 4].sample.day.from_now
  { status:, author:, invitee:, when: pair_date, duration: 30.minutes }
end

begin
  puts 'Seeding users...'

  user_data = []
  # create admin and mod data
  2.times do |idx|
    user_data.push(generate_user_data(role: 'admin', idx:))
    user_data.push(generate_user_data(role: 'moderator', idx:))
  end

  # create member data
  4.times do |idx|
    user_data.push(generate_user_data(role: 'member', idx:))
  end

  # create applicant data
  24.times do |idx|
    user_data.push(generate_user_data(role: 'applicant', idx:))
  end

  User.transaction do
    user_data.each do |data|
      User.create!(data)
      puts "User #{data[:email]} created"
    end
  end
  users = User.all
  puts 'Users seeded successfully!'

  puts 'Seeding pair requests...'
  pair_request_data = []
  5.times do
    pair_request_data.push(generate_pair_request_data(status: 'pending', users:))
    pair_request_data.push(generate_pair_request_data(status: 'rejected', users:))
    pair_request_data.push(generate_pair_request_data(status: 'accepted', users:, pair_date: Time.now))
  end

  PairRequest.transaction do
    pair_request_data.each do |data|
      PairRequest.create!(data)
    end
  end
  puts 'Pair requests seeded successfully!'

  puts 'Seeding completed pair requests with feedback drafts...'

  completed_pair_request_data = Array.new(5) do
    author, invitee = users.sample(2)
    { status: 'completed', author:, invitee:, when: 30.minutes.ago, duration: 30.minutes }
  end

  PairRequest.transaction do
    completed_pair_request_data.each do |data|
      PairRequest.create!(data).create_draft_feedback!
    end
  end

  puts 'Seeding a Standup Meeting Group'
  standup_meeting_group = StandupMeetingGroup.create!(
    name: 'PairApp',
    start_time: Time.new(2023, 1, 1, 9, 0, 0)
  )

  users.each do |user|
    standup_meeting_group.users << user
    7.times do |day_count|
      StandupMeeting.create!(
        meeting_date: (1.week.ago + (day_count + 1).days),
        user:,
        standup_meeting_group:
      )
    end
  end
  puts 'Completed seeding standup meeting group!'

  puts 'Seeding a user_mentee_application...'

  # Current upcoming cohort
  active_cohort = UserMenteeApplicationCohort.create!(
    name: 'Fall 2023',
    active_date_range: Time.zone.today..3.months.from_now
  )

  original_cohort = UserMenteeApplicationCohort.create!(
    name: 'Original',
    active_date_range: 3.months.ago..Date.yesterday,
    active: false
  )

  applicants = users.where(role: User.roles[:applicant])
  user_mentee_application_data = applicants.map.with_index do |applicant, idx|
    {
      user_id: applicant.id,
      user_mentee_application_cohort: idx.even? ? active_cohort : original_cohort,
      city: Faker::Address.city,
      state: Faker::Address.state,
      country: Faker::Address.country,
      reason_for_applying: Faker::Lorem.paragraph,
      linkedin_url: "https://linkedin.com/in/#{Faker::Internet.name}",
      github_url: "https://github.com/#{Faker::Internet.name}",
      learned_to_code: Faker::Lorem.paragraph,
      project_experience: Faker::Lorem.paragraph,
      available_hours_per_week: 10,
      referral_source: Faker::Lorem.paragraph,
      additional_information: Faker::Lorem.paragraph
    }
  end

  UserMenteeApplication.transaction do
    user_mentee_application_data.each do |data|
      UserMenteeApplication.create!(data)
    end
  end
rescue StandardError => e
  puts "Error occurred while seeding: #{e.message}"
  puts e.backtrace.join("\n")
end
