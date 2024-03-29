# == Schema Information
#
# Table name: billing_manager_subscription_items
#
#  id              :uuid             not null, primary key
#  quantity        :integer          default(1), not null
#  stripe_data     :jsonb
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  price_id        :uuid
#  stripe_id       :string
#  subscription_id :uuid
#
# Indexes
#
#  index_billing_manager_subscription_items_on_price_id         (price_id)
#  index_billing_manager_subscription_items_on_stripe_id        (stripe_id) UNIQUE
#  index_billing_manager_subscription_items_on_subscription_id  (subscription_id)
#  unique_price_feature                                         (subscription_id,price_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (price_id => billing_manager_prices.id)
#  fk_rails_...  (subscription_id => billing_manager_subscriptions.id)
#
module BillingManager
  class SubscriptionItem < ApplicationRecord
    belongs_to(:price)
    belongs_to(:subscription)
    has_many(:record_usages, dependent: :destroy)

    validates(:price_id, uniqueness: { scope: :subscription_id, case_sensitive: false })
  end
end
