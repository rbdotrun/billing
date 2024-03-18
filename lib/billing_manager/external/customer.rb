module BillingManager::External
  module Customer
    # BillingManager::External::Customer.list(BillingManager::Owner.first.stripe_secret_key)
    def self.list(api_key, limit: 30, starting_after: nil)
      Stripe.api_key = api_key
      Stripe::Customer.list(limit:, starting_after:)
    end

    # BillingManager::External::Customer.import(BillingManager::Owner.first)
    def self.import(owner, starting_after: nil)
      data = list(owner.stripe_secret_key, limit: 100, starting_after:)

      dataset = data.data.map do |remote_customer|
        { stripe_id: remote_customer.id, stripe_data: remote_customer }
      end

      BillingManager::Customer.upsert_all(dataset, unique_by: :stripe_id)

      if data.has_more
        import(owner, starting_after: data.data.last.id)
      end
    end
  end
end