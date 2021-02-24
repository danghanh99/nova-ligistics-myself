FactoryBot.define do
  factory :export do
    user
    inventory
    import
    customer
    sell_price { 10_000 }
    quantity { 5 }
    description { 'This is export' }
    exported_date { Date.today }
  end
end
