begin
  puts "Seeding users..."

  user_data = [
    { email: "admin@user.com", password: "password", role: "admin" },
    { email: "user1@user.com", password: "password", role: "member" },
    { email: "user2@user.com", password: "password", role: "member" },
    { email: "user3@user.com", password: "password", role: "member" }
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

  puts "Seeding a Standup Meeting Group"
  standup_group = StandupMeetingGroup.create!(
    name: 'PairApp',
    start_time: Time.new(2023,1,1,9,0,0)
  )
  users.each do |user|
    standup_group.users << user
  end
  puts "Completed seeding standup meeting group!"
  
rescue StandardError => e
  puts "Error occurred while seeding: #{e.message}"
  puts e.backtrace.join("\n")
end
