FactoryBot.define do
  factory :form_objects do
    postal_code    { '123-4567' }
    prefectures_id { Faker::Number.within(range: 2..48) }
    municipalities { '市区町村' }
    address        { Faker::Address.street_address }
    building_name  { '建物名' }
    phone_number   { Faker::Number.number(digits: 11) }
    item_id        { association :item }
    user_id        { association :user }
    token          { 'tok_abcdefghijk00000000000000000' }
  end
end
