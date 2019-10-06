FactoryBot.define do
  factory :user do
    name { 'テストユーザ' }
    email { 'test1@example.com' }
    password { 'password' }
  end
end
