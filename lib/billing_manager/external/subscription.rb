module BillingManager::External
  module Subscription
    # BillingManager::External::Subscription.list(BillingManager::Owner.first.stripe_secret_key)
    def self.list(api_key, limit: 30, starting_after: nil, status: nil)
      Stripe.api_key = api_key
      Stripe::Subscription.list(limit:, starting_after:, status:)
    end

    # BillingManager::External::Subscription.import(BillingManager::Owner.first)
    def self.import(owner, starting_after: nil, status: nil)
      data = list(owner.stripe_secret_key, starting_after:, status:)

      subscription_dataset = dataset = data.data.map do |remote_subscription|
        customer = BillingManager::Customer.find_by(stripe_id: remote_subscription.customer)
        customer = fetch_missing_customer(owner.stripe_secret_key, remote_subscription.customer) unless customer

        { customer_id: customer.id, stripe_id: remote_subscription.id, stripe_data: remote_subscription, status: remote_subscription.status }
      end

      BillingManager::Subscription.upsert_all(subscription_dataset, unique_by: :stripe_id)

      subscription_item_dataset = dataset = data.data.flat_map do |remote_subscription|
        remote_subscription.items.map do |item|
          subscription = BillingManager::Subscription.find_by(stripe_id: item.subscription)
          price = BillingManager::Price.find_by(stripe_id: item.price.id)

          if price.nil?
            price = fetch_missing_price(owner.stripe_secret_key, item.price.id)
          end

          { subscription_id: subscription.id, price_id: price.stripe_id, stripe_id: item.id, stripe_data: item }
        end
      end

      BillingManager::SubscriptionItem.upsert_all(subscription_item_dataset, unique_by: :stripe_id)

      if data.has_more
        import(owner, starting_after: data.data.last.id, status:)
      end
    end

    def self.fetch_missing_customer(api_key, customer_id)
      Stripe.api_key = api_key
      remote_customer = Stripe::Customer.retrieve(customer_id)
      BillingManager::Customer.upsert_all([{ stripe_id: remote_customer.id, stripe_data: remote_customer }], unique_by: :stripe_id)
      BillingManager::Customer.find_by(stripe_id: customer_id)
    end

    def self.fetch_missing_price(api_key, price_id)
      Stripe.api_key = api_key
      price = Stripe::Price.retrieve(price_id)
      BillingManager::Price.upsert_all([BillingManager::External::Price.format_price(price)], unique_by: :stripe_id)
      BillingManager::Price.find_by(stripe_id: price_id)
    end
  end
end