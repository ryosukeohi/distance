FactoryBot.define do
  factory :record_image do
    record_id { Faker::Lorem.characters(number: 1) }
    image_id { Faker::Lorem.characters(number: 20) }
  end
end