FactoryBot.define do
  factory :comment do
    content { "MyText" }
    user { nil }
    task { nil }
  end
end
