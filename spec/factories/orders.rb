FactoryBot.define do
  factory :order do
    title { 'Test' }
    user_id { 1 }
    event_id { 1 }
    order_amount { 2 }
    total_amount { 2 }
    order_currency { 'usd' }
  end
end
