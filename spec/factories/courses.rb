FactoryBot.define do
  factory :course do
    title { Faker::Lorem.characters(number: 20) }
    description { Faker::Lorem.characters(number: 50) }
    distance { Faker::Lorem.characters(number: 6) }
    latitude { Faker::Lorem.characters(number: 10) }
    longitude { Faker::Lorem.characters(number: 10) }
    address { Faker::Lorem.characters(number: 20) }
    user
  end
end
