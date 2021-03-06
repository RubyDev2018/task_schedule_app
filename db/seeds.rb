# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

1.times do |n|
  name  = "管理者ユーザー"
  admin = true
  email = "management_user@taskmanagement.com"
  introduce = "Hello administrator"
  sex = "男"
  birthday = "1980-01-01"
  password = "password"
  User.create!(name:  name,
               email: email,
               introduce: introduce,
               sex: sex,
               birthday: birthday,
               admin: admin,
               password:              password,
               password_confirmation: password)
end

28.times do |n|
  name  = Faker::Name.name
  admin = false
  email = "task_user-#{n+10}@taskcompany.org"
  introduce = Faker::Lorem.sentence(5)
  if n % 2 == 0
    sex = "男"
  else
    sex = "女"
  end
  birthday = "1990-01-01"
  password = "password"
  User.create!(name:  name,
               email: email,
               introduce: introduce,
               sex: sex,
               birthday: birthday,
               admin: admin,
               password:  password,
               password_confirmation: password)
end
