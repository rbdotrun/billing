FactoryBot.define do
  factory :subscription, class: BillingManager::Subscription.name do
    association(:customer)
    status { "sample" }
  end
end
