FactoryBot.define do
  factory :price, class: BillingManager::Price.name do
    association(:feature)
    label { SecureRandom.uuid }
    price { 10 }
  end
end
