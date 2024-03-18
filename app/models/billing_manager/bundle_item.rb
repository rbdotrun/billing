# == Schema Information
#
# Table name: billing_manager_bundle_items
#
#  id         :uuid             not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  bundle_id  :uuid
#  price_id   :uuid
#
# Indexes
#
#  index_billing_manager_bundle_items_on_bundle_id  (bundle_id)
#  index_billing_manager_bundle_items_on_price_id   (price_id)
#
# Foreign Keys
#
#  fk_rails_...  (bundle_id => billing_manager_bundles.id)
#  fk_rails_...  (price_id => billing_manager_prices.id)
#
module BillingManager
  class BundleItem < ApplicationRecord
    belongs_to(:bundle)
  end
end
