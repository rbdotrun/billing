# == Schema Information
#
# Table name: billing_manager_customers
#
#  id          :uuid             not null, primary key
#  stripe_data :jsonb
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  owner_id    :uuid
#  stripe_id   :string
#
# Indexes
#
#  index_billing_manager_customers_on_owner_id  (owner_id)
#
# Foreign Keys
#
#  fk_rails_...  (owner_id => billing_manager_owners.id)
#
module BillingManager
  class Customer < ApplicationRecord
    belongs_to(:owner)
    has_many(:subscriptions)
  end
end
