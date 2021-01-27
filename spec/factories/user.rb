FactoryBot.define do
  factory :user do
    email { 'admin@novahub.vn' }
    password { '123456' }
    name { FFaker::Internet.name }
    phone { '0123456789' }
    address { FFaker::Address.street_address }
  end
end
