# == Schema Information
#
# Table name: billing_manager_bundles
#
#  id         :uuid             not null, primary key
#  label      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  owner_id   :uuid
#
# Indexes
#
#  index_billing_manager_bundles_on_owner_id  (owner_id)
#
# Foreign Keys
#
#  fk_rails_...  (owner_id => billing_manager_owners.id)
#
module BillingManager
  class Bundle < ApplicationRecord
    belongs_to(:owner)
    has_many(:bundle_items)
    has_one_attached(:visual)
    validates(:label, presence: true)
  end
end
