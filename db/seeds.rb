# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

include Faker

10.times do
  User.create!(
  email: Faker::Internet.email,
  password: Faker::Internet.password
  )
end

	user = User.first
	user.update_attributes!(
		email: 'mollie.mcintyre9@gmail.com',
		password: 'helloworld'
	)
#   name: "Anthony",
#   email: "newemail@blocipedia.com",
#   password: "password"
# )
# user_1.skip_confirmation!
# user_1.save!

users = User.all

20.times do
    Wiki.create!(
    user: users.sample,
    title: Faker::Hipster.sentence,
    body: Faker::Hipster.paragraph
  )
end

wikis = Wiki.all

puts "Seeds finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"