FactoryBot.define do
  factory :feature, class: BillingManager::Feature.name do
    association(:owner)
  end
end
