FactoryBot.define do
  factory :task do
    name { 'テストをかく'}
    description { 'Rspec&Capybara&FactoryBOtを準備'}
    user
  end
end

