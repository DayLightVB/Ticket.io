FactoryBot.define do
  factory :event do
    title { 'test' }
    description { 'test test test ' }
    duration { 30 }
    event_entry_tickets { 2 }
    price { 1005 }
  end
end
