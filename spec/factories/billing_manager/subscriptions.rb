FactoryBot.define do
  factory :subscription, class: BillingManager::Subscription.name do
    association(:customer)
  end
end
