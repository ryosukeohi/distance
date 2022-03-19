FactoryBot.define do
  factory :record do
    distance { Faker::Lorem.characters(number: 5) }
    user_id {3}
    start_time {'2022/01/01'}
  end
end
