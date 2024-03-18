FactoryBot.define do
  factory :bundle_item, class: BillingManager::BundleItem.name do
    association(:bundle)
  end
end
