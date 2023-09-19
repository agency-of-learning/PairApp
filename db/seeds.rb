require 'faker'
begin
  puts "Seeding users..."

  user_data = [
    { first_name: 'Admin', last_name: Faker::Name.last_name, email: "admin@aol.com", password: "password", role: "admin" },
    { first_name: 'Mod', last_name: Faker::Name.last_name, email: "mod@aol.com", password: "password", role: "moderator" },
    { first_name: 'User1', last_name: Faker::Name.last_name, email: "user1@aol.com", password: "password", role: "member" },
    { first_name: 'User2', last_name: Faker::Name.last_name, email: "user2@aol.com", password: "password", role: "member" },
    { first_name: 'User3', last_name: Faker::Name.last_name, email: "user3@aol.com", password: "password", role: "member" },
    { first_name: 'Applicant1', last_name: Faker::Name.last_name, email: "applicant1@aol.com", password: "password", role: "applicant" },
    { first_name: 'Applicant2', last_name: Faker::Name.last_name, email: "applicant2@aol.com", password: "password", role: "applicant" },
    { first_name: 'Applicant3', last_name: Faker::Name.last_name, email: "applicant3@aol.com", password: "password", role: "applicant" },
  ]

  users = []

  User.transaction do
    user_data.each do |data|
      user = User.create!(data)
      users << user
      puts "User #{user.email} created"
    end
  end
  puts "Users seeded successfully!"

  puts "Seeding pair requests..."
  pair_request_data = [
    { status: "pending", author: users[1], invitee: users[2], when: 1.day.from_now, duration: 30.minutes },
    { status: "pending", author: users[1], invitee: users[3], when: 1.day.from_now, duration: 30.minutes },
    { status: "pending", author: users[2], invitee: users[3], when: 1.day.from_now, duration: 45.minutes },
    { status: "rejected", author: users[1], invitee: users[2], when: 1.day.from_now, duration: 30.minutes },
    { status: "accepted", author: users[1], invitee: users[2], when: 5.day.from_now, duration: 60.minutes },
    { status: "accepted", author: users[2], invitee: users[3], when: Time.now, duration: 60.minutes },
    { status: "accepted", author: users[2], invitee: users[3], when: Time.now, duration: 60.minutes },
    { status: "accepted", author: users[2], invitee: users[3], when: Time.now, duration: 60.minutes },
    { status: "accepted", author: users[3], invitee: users[2], when: Time.now, duration: 60.minutes },
    { status: "accepted", author: users[3], invitee: users[2], when: Time.now, duration: 60.minutes },
    { status: "rejected", author: users[3], invitee: users[1], when: 20.days.from_now, duration: 15.minutes },
  ]

  PairRequest.transaction do
    pair_request_data.each do |data|
      PairRequest.create!(data)
    end
  end
  puts "Pair requests seeded successfully!"

  puts "Seeding completed pair requests with feedback drafts..."
  completed_pair_request_data =[
  { status: "completed", author: users[1], invitee: users[2], when: Time.current - 30.minutes,  duration: 30.minutes },
  { status: "completed", author: users[1], invitee: users[2], when: Time.current - 60.minutes,  duration: 30.minutes },
  { status: "completed", author: users[1], invitee: users[3], when: Time.current - 45.minutes,  duration: 30.minutes },
  { status: "completed", author: users[3], invitee: users[1], when: Time.current - 60.minutes,  duration: 30.minutes },
  { status: "completed", author: users[2], invitee: users[1], when: Time.current - 50.minutes,  duration: 30.minutes },
  ]
  
  PairRequest.transaction do
    completed_pair_request_data.each do |data|
      PairRequest.create!(data).create_draft_feedback!
    end
  end

  puts "Seeding a Standup Meeting Group"
  standup_meeting_group = StandupMeetingGroup.create!(
    name: 'PairApp',
    start_time: Time.new(2023,1,1,9,0,0)
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
  puts "Completed seeding standup meeting group!"


  puts "Seeding a user_mentee_application..."

  cohort = UserMenteeApplicationCohort.create!(
    name: 'Original',
    active_date_range: Date.today..3.months.from_now
  )

  user_mentee_application_data = [
    {
      user_id: users[4].id,
      user_mentee_application_cohort: cohort,
      city: Faker::Address.city,
      state: Faker::Address.state,
      country: Faker::Address.country,
      reason_for_applying: Faker::Lorem.paragraph, 
      linkedin_url: Faker::Internet.url, 
      github_url: Faker::Internet.url, 
      learned_to_code: Faker::Lorem.paragraph, 
      project_experience: Faker::Lorem.paragraph, 
      available_hours_per_week: 10, 
      referral_source: Faker::Lorem.paragraph, 
      additional_information: Faker::Lorem.paragraph
    },
    {
      user_id: users[5].id,
      user_mentee_application_cohort: cohort,
      city: Faker::Address.city,
      state: Faker::Address.state,
      country: Faker::Address.country,
      reason_for_applying: Faker::Lorem.paragraph,
      linkedin_url: Faker::Internet.url,
      github_url: Faker::Internet.url,
      learned_to_code: Faker::Lorem.paragraph,
      project_experience: Faker::Lorem.paragraph,
      available_hours_per_week: 10,
      referral_source: Faker::Lorem.paragraph,
      additional_information: Faker::Lorem.paragraph
    },
    {
      user_id: users[6].id,
      user_mentee_application_cohort: cohort,
      city: Faker::Address.city,
      state: Faker::Address.state,
      country: Faker::Address.country,
      reason_for_applying: Faker::Lorem.paragraph,
      linkedin_url: Faker::Internet.url,
      github_url: Faker::Internet.url,
      learned_to_code: Faker::Lorem.paragraph,
      project_experience: Faker::Lorem.paragraph,
      available_hours_per_week: 10,
      referral_source: Faker::Lorem.paragraph,
      additional_information: Faker::Lorem.paragraph
    }
  ]

  UserMenteeApplication.transaction do
    user_mentee_application_data.each do |data|
      UserMenteeApplication.create!(data)
    end
  end

rescue StandardError => e
  puts "Error occurred while seeding: #{e.message}"
  puts e.backtrace.join("\n")
end
