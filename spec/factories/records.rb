FactoryBot.define do
  factory :record do
    distance { Faker::Lorem.characters(number: 5) }
    user_id { Faker::Lorem.characters(number: 2) }
    start_time { Faker::Lorem.characters(number: 15) }
  end
end
