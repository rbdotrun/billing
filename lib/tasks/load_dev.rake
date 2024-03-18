# bundle exec rake load_dev

task load_dev: :environment do
  # BillingManager::Owner.destroy_all

  owner = BillingManager::Owner.create(
    stripe_publishable_key: ENV["NOTIPLUS_STRIPE_PUBLISHABLE_KEY"],
    stripe_secret_key: ENV["NOTIPLUS_STRIPE_SECRET_KEY"]
  )

  BillingManager::Import.all(owner)
end