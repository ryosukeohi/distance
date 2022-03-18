FactoryBot.define do
  factory :record do
    distance {Faker::Lorem.characters(number:5)}
  end
end