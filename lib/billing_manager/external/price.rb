module BillingManager::External
  module Price
    def self.list(api_key, limit: 30, starting_after: nil, active: nil)
      Stripe.api_key = api_key
      Stripe::Price.list(limit:, starting_after:, active:, expand: ["data.tiers"])
    end

    def self.import(owner, starting_after: nil, active: nil)
      data = list(owner.stripe_secret_key, limit: 100, starting_after:, active:)

      price_dataset = data.data.map { |remote_price| format_price(remote_price) }

      BillingManager::Price.upsert_all(price_dataset, unique_by: :stripe_id)

      tiers_dataset = data.data.flat_map do |remote_price|
        next unless remote_price.respond_to?(:tiers)

        price = BillingManager::Price.find_by(stripe_id: remote_price.id)

        remote_price.tiers.flat_map do |tier|
          { price_id: price.id, flat_amount: tier.flat_amount, unit_amount: tier.unit_amount, up_to: tier.up_to }
        end
      end.compact

      BillingManager::PriceTier.upsert_all(tiers_dataset, unique_by: %w[price_id flat_amount unit_amount up_to])

      if data.has_more
        import(owner, starting_after: data.data.last.id, active:)
      end
    end

    def self.format_price(remote_price)
      feature = BillingManager::Feature.find_by(stripe_id: remote_price.product)

      {
        feature_id: feature.id,
        stripe_id: remote_price.id,
        price: remote_price.unit_amount,
        recurring: !!remote_price.recurring,
        recurring_interval: remote_price.recurring&.interval,
        recurring_interval_count: remote_price.recurring&.interval_count,
        usage_type: remote_price.recurring&.usage_type,
        tiers_mode: remote_price.tiers_mode,
        stripe_data: remote_price,
        label: remote_price.nickname || "undefined"
      }
    end
  end
end