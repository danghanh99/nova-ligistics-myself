FactoryBot.define do
  factory :product do
    name { FFaker::Internet.name }
    description { 'This is important product' }
  end
end
