
User.create!(first_name: "Joey", last_name: "Chamberlin", email: "joe@joe.com", password: "password")
User.create!(first_name: "Jeff", last_name: "Keslin", email: "jkeslin@gmail.com", password: "password")
User.create!(first_name: "Steve", last_name: "Pikelny", email: "spike716@gmail.com", password: "password")
User.create!(first_name: "Tanner", last_name: "Blumer", email: "blumer.tanner@gmail.com":, password: "password")

extra_users = 50
extra_users.times do
  User.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: "password")
end


Transaction.create!(debtor_id: 2, creditor_id: 1, amount: 10, description: Faker::Hacker.say_something_smart, approved: true, paid: false, squaring_id: nil, private_trans: false)
Transaction.create!(debtor_id: 3, creditor_id: 1, amount: 20, description: Faker::Hacker.say_something_smart, approved: true, paid: false, squaring_id: nil, private_trans: false)
Transaction.create!(debtor_id: 4, creditor_id: 1, amount: 5, description: Faker::Hacker.say_something_smart, approved: true, paid: false, squaring_id: nil, private_trans: false)
Transaction.create!(debtor_id: 1, creditor_id: 2, amount: 5, description: Faker::Hacker.say_something_smart, approved: true, paid: false, squaring_id: nil, private_trans: false)
Transaction.create!(debtor_id: 3, creditor_id: 2, amount: 10, description: Faker::Hacker.say_something_smart, approved: true, paid: false, squaring_id: nil, private_trans: false)
Transaction.create!(debtor_id: 1, creditor_id: 3, amount: 5, description: Faker::Hacker.say_something_smart, approved: true, paid: false, squaring_id: nil, private_trans: false)
Transaction.create!(debtor_id: 2, creditor_id: 4, amount: 5, description: Faker::Hacker.say_something_smart, approved: true, paid: false, squaring_id: nil, private_trans: false)
Transaction.create!(debtor_id: 3, creditor_id: 4, amount: 10, description: Faker::Hacker.say_something_smart, approved: true, paid: false, squaring_id: nil, private_trans: false)

#joey   = 1
#jeff   = 2
#steve  = 3
#tanner = 4

200.times do
  Transaction.create!(debtor_id: rand(1..extra_users)+4, creditor_id: rand(1..extra_users)+4, amount: rand(1..100), description: Faker::Commerce.product_name, approved: true, paid: false, squaring_id: nil, private_trans: false)
end
