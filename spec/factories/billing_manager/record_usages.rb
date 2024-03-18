FactoryBot.define do
  factory :record_usage do
    association(:subscription_item)
    stripe_id { SecureRandom.uuid }
    stripe_data { { some: :data } }
  end
end
