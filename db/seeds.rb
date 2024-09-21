User.create!(name: "Hieu",
             email: "hieu@gmail.com",
             password: "123456",
             password_confirmation: "123456",
             admin: true) 

99.times do |n|
  name = Faker::Name.name
  email = "example-#{n + 2}@railstutorial.org" 
  password = "password"
  user = User.find_or_initialize_by(email: email)
  user.name = name
  user.password = password
  user.password_confirmation = password
  user.save! 
end