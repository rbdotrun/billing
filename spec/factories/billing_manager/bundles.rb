FactoryBot.define do
  factory :bundle, class: BillingManager::Bundle.name do
    association(:owner)
  end
end
