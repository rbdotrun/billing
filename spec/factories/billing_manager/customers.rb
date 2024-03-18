FactoryBot.define do
  factory :customer, class: BillingManager::Customer.name do
    association(:owner)
  end
end
