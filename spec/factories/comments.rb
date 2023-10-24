FactoryBot.define do
  factory :comment do
    content { "MyText" }
    user { nil }
    prediction { nil }
  end
end
