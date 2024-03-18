# == Schema Information
#
# Table name: billing_manager_receipts
#
#  id              :uuid             not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  subscription_id :uuid
#
# Indexes
#
#  index_billing_manager_receipts_on_subscription_id  (subscription_id)
#
# Foreign Keys
#
#  fk_rails_...  (subscription_id => billing_manager_receipts.id)
#
module BillingManager
  class Receipt < ApplicationRecord
    belongs_to(:subscription)
  end
end
