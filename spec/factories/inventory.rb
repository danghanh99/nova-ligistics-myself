FactoryBot.define do
  factory :inventory do
    name { FFaker::Name.name }
    description { 'This is description' }
    address { FFaker::Address.street_address }
  end
end
