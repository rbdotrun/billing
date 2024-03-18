module BillingManager::External
  module Product
    # BillingManager::External::Product.list(BillingManager::Owner.first.stripe_secret_key)
    def self.list(api_key, limit: 30, starting_after: nil)
      Stripe.api_key = api_key
      Stripe::Product.list(limit:, starting_after:)
    end

    # BillingManager::External::Customer.import(BillingManager::Owner.first)
    def self.import(owner, starting_after: nil)
      data = list(owner.stripe_secret_key, limit: 100, starting_after:)

      dataset = data.data.map do |remote_product|
        {
          owner_id: owner.id,
          stripe_id: remote_product.id,
          stripe_data: remote_product,
          label: remote_product.name,
          active: remote_product.active
        }
      end

      BillingManager::Feature.upsert_all(dataset, unique_by: :stripe_id)

      if data.has_more
        import(owner, starting_after: data.data.last.id)
      end
    end
  end
end