# == Schema Information
#
# Table name: billing_manager_record_usages
#
#  id                   :uuid             not null, primary key
#  stripe_data          :jsonb            not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  stripe_id            :string           not null
#  subscription_item_id :uuid
#
# Indexes
#
#  index_billing_manager_record_usages_on_subscription_item_id  (subscription_item_id)
#
# Foreign Keys
#
#  fk_rails_...  (subscription_item_id => billing_manager_subscription_items.id)
#
module BillingManager
  class RecordUsage < ApplicationRecord
    belongs_to(:subscription_item)
  end
end
