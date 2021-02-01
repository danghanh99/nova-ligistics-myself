FactoryBot.define do
  factory :customer do
    name { FFaker::Name.name }
    phone_number { FFaker::PhoneNumber.phone_number }
    address { FFaker::Address.street_address }
  end
end
