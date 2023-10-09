FactoryBot.define do
  factory :prediction do
    user { nil }
    match_id { 1 }
    predicted_result { "MyString" }
  end
end
