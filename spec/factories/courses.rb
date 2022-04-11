FactoryBot.define do
  factory :course do
    title { 'サンプル' }
    description { 'サンプルテキスト' }
    distance { 10 }
    latitude { 35.681236 }
    longitude { 139.767125 }
    address { '東京駅' }
    user
  end
end
