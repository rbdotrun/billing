FactoryBot.define do
  factory :owner, class: BillingManager::Owner.name do
    parent_type { "User" }
    parent_id { SecureRandom.uuid }
    stripe_publishable_key { SecureRandom.uuid }
    stripe_secret_key { SecureRandom.uuid }
  end
end
