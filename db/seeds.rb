# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

users = User.create([ { email: "user1@email.com", time_zone: "Eastern Time (US & Canada)" },
                      { email: "user2@email.com", time_zone: "Eastern Time (US & Canada)" },
                      { email: "user3@email.com", time_zone: "Pacific Time (US & Canada)" }
                    ]) 
p "Created #{users.count} users"



pair_requests = PairRequest.create([ 
  { author_id: users[0].id, acceptor_id: users[1].id, when: "2021-03-30 12:00:00", duration: 1.5 },
  { author_id: users[0].id, acceptor_id: users[1].id, when: "2023-04-01 13:00:00", duration: 1.5 }
]) 

p "Created #{pair_requests.count} pair requests"