FactoryBot.define do
  factory :supplier do
    name { 'Tran Quang Huy' }
    phone { '0123456789' }
    address { FFaker::Address.street_address }
    description { 'This is important supplier' }
  end
end
