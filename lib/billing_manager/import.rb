module BillingManager
  module Import
    def self.all(owner)
      External::Product.import(owner)
      PriceTier.delete_all
      External::Price.import(owner, active: true)
      External::Price.import(owner, active: false)
      External::Customer.import(owner)

      %w[incomplete incomplete_expired trialing active past_due canceled unpaid].each do |status|
        External::Subscription.import(owner, status:)
      end
    end
  end
end
