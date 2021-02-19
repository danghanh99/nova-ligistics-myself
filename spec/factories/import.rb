FactoryBot.define do
  factory :import do
    product
    user
    supplier
    inventory
    retail_price { 10_000 }
    quantity { 10 }
    available_quantity { 10 }
    imported_date { Date.today }
    description { 'This is important product' }
  end
end
