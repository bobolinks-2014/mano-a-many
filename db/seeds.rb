
user1 = User.create!(first_name: "Joey", last_name: "Chamberlin", email: "joe@joe.com", password: "password", password_confirmation: "password")
user2 = User.create!(first_name: "Jeff", last_name: "Keslin", email: "jkeslin@gmail.com", password: "password", password_confirmation: "password")
user3 = User.create!(first_name: "Steve", last_name: "Pikelny", email: "spike716@gmail.com", password: "password", password_confirmation: "password")
user4 = User.create!(first_name: "Tanner", last_name: "Blumer", email: "blumer.tanner@gmail.com", password: "password", password_confirmation: "password")

# extra_users = 50
# extra_users.times do

#   User.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: "password", password_confirmation: "password")

# end



Transaction.create!(debtor_id: user2.id, creditor_id: user1.id, amount: 10, description: Faker::Hacker.say_something_smart, approved: true, closed: false, squaring_event_id: nil, private_trans: false)
Transaction.create!(debtor_id: user3.id, creditor_id: user1.id, amount: 20, description: Faker::Hacker.say_something_smart, approved: true, closed: false, squaring_event_id: nil, private_trans: false)
Transaction.create!(debtor_id: user4.id, creditor_id: user1.id, amount: 5, description: Faker::Hacker.say_something_smart, approved: true, closed: false, squaring_event_id: nil, private_trans: false)
Transaction.create!(debtor_id: user1.id, creditor_id: user2.id, amount: 5, description: Faker::Hacker.say_something_smart, approved: true, closed: false, squaring_event_id: nil, private_trans: false)
Transaction.create!(debtor_id: user3.id, creditor_id: user2.id, amount: 10, description: Faker::Hacker.say_something_smart, approved: true, closed: false, squaring_event_id: nil, private_trans: false)
Transaction.create!(debtor_id: user1.id, creditor_id: user3.id, amount: 5, description: Faker::Hacker.say_something_smart, approved: true, closed: false, squaring_event_id: nil, private_trans: false)
Transaction.create!(debtor_id: user2.id, creditor_id: user4.id, amount: 5, description: Faker::Hacker.say_something_smart, approved: true, closed: false, squaring_event_id: nil, private_trans: false)
Transaction.create!(debtor_id: user3.id, creditor_id: user4.id, amount: 10, description: Faker::Hacker.say_something_smart, approved: true, closed: false, squaring_event_id: nil, private_trans: false)

group = Group.create!
Membership.create!(user_id: user1.id, group_id:group.id)
Membership.create!(user_id: user2.id, group_id:group.id)
Membership.create!(user_id: user3.id, group_id:group.id)
Membership.create!(user_id: user4.id, group_id:group.id)
#joey   = 1
#jeff   = 2
#steve  = 3
#tanner = 4

# 200.times do
#   Transaction.create!(debtor_id: rand(1..extra_users)+4, creditor_id: rand(1..extra_users)+4, amount: rand(1..100), description: Faker::Commerce.product_name, approved: true, closed: false, squaring_event_id: nil, private_trans: false)

# end

