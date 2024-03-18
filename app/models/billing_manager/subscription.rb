# == Schema Information
#
# Table name: billing_manager_subscriptions
#
#  id          :uuid             not null, primary key
#  status      :string           not null
#  stripe_data :jsonb
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  customer_id :uuid
#  stripe_id   :string
#
# Indexes
#
#  index_billing_manager_subscriptions_on_customer_id  (customer_id)
#  index_billing_manager_subscriptions_on_stripe_id    (stripe_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (customer_id => billing_manager_customers.id)
#
module BillingManager
  class Subscription < ApplicationRecord
    belongs_to(:customer)
    has_many(:subscription_items, dependent: :destroy)
    has_many(:receipts, dependent: :destroy)
  end
end
