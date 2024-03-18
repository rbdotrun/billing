FactoryBot.define do
  factory :owner, class: BillingManager::Owner.name do
    parent_type { "User" }
    parent_id { SecureRandom.uuid }
  end
end
