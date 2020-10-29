FactoryBot.define do
  factory :item do
    title       { Faker::Lorem.word }
    explain     { Faker::Lorem.sentence }
    category_id { Faker::Number.within(range: 2..11) }
    status_id   { Faker::Number.within(range: 2..7) }
    charge_id   { Faker::Number.within(range: 2..3) }
    area_id     { Faker::Number.within(range: 2..48) }
    arrival_id  { Faker::Number.within(range: 2..4) }
    price       { Faker::Number.between(from: 300, to: 9_999_999) }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
