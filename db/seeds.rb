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

  completed_pair_request_data =[
  { status: "accepted", author: users[1], invitee: users[2], when: Time.now - 1.day,  duration: 30.minutes },
  { status: "accepted", author: users[1], invitee: users[2], when: Time.now - 2.day,  duration: 30.minutes },
  { status: "accepted", author: users[1], invitee: users[3], when: Time.now - 3.day,  duration: 30.minutes },
  { status: "accepted", author: users[3], invitee: users[1], when: Time.now - 4.day,  duration: 30.minutes },
  { status: "accepted", author: users[2], invitee: users[1], when: Time.now - 5.day,  duration: 30.minutes },
  ]
  
  completed_pair_requests = []
  PairRequest.transaction do
    completed_pair_request_data.each do |data|
      pair_request = PairRequest.new(data)
      pair_request.save(validate: false)
      # pair_request.create_draft_feedback!
      completed_pair_requests << pair_request
    end
  end

  puts "Pair requests seeded successfully!"

  puts "Seeding feedbacks..."
  completed_pair_requests.each do |pair_request|
    pair_request.update(status: 'completed')
  
    data = Feedback::DATA_OBJECT
    pair_request.references.build([
      { author: pair_request.author, receiver: pair_request.invitee, data: data },
      { author: pair_request.invitee, receiver: pair_request.author, data: data }
    ])
  
    pair_request.save(validate: false)
  end
  puts "Feedbacks seeded successfully"



rescue StandardError => e
  puts "Error occurred while seeding: #{e.message}"
  puts e.backtrace.join("\n")
end

private

def create_draft_feedback!
  data = Feedback::DATA_OBJECT
  references.build([
    { author:, receiver: invitee, data: },
    { author: invitee, receiver: author, data: }
  ])

  save(validate: false)
end