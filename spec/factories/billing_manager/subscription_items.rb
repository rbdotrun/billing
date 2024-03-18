FactoryBot.define do
  factory :subscription_item, class: BillingManager::SubscriptionItem.name do
    association(:subscription)
    association(:price)
  end
end
