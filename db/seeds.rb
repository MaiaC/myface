require 'faker'

30.times do |n|
  u = User.new
  u.name = Faker::Name.name
  u.email = "mybook2user#{n}@email.com"
  u.password = "password"
  u.password_confirmation = "password"
  u.save
end

User.all.each do |u|
  u.posts.create!(body: Faker::GreekPhilosophers.quote)
  u.posts.create!(body: Faker::Hipster.sentence)
end
