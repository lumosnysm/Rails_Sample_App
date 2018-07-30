User.create! name: Settings.example_name,
  email: Settings.example_email,
  password: Settings.example_pass,
  password_confirmation:  Settings.example_pass,
  admin: true,
  activated: true,
  activated_at: Time.zone.now

Settings.example_users.times do |n|
name  = Faker::Name.name
email = Settings.before + "#{n+1}" + Settings.after
password = Settings.pass
User.create! name: name,
  email: email,
  password: password,
  password_confirmation: password,
  activated: true,
  activated_at: Time.zone.now
end

users = User.order(:created_at).take Settings.example_users_post
Settings.example_posts.times do
  content = Faker::Lorem.sentence Settings.example_content
  users.each {|user| user.microposts.create!(content: content)}
end
