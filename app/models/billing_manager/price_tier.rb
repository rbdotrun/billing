# == Schema Information
#
# Table name: billing_manager_price_tiers
#
#  id          :uuid             not null, primary key
#  flat_amount :float
#  unit_amount :float
#  up_to       :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  price_id    :uuid
#
# Indexes
#
#  index_billing_manager_price_tiers_on_price_id  (price_id)
#  unique_tiers                                   (price_id,flat_amount,unit_amount,up_to) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (price_id => billing_manager_prices.id)
#
module BillingManager
  class PriceTier < ApplicationRecord
    belongs_to(:price)
  end
end
