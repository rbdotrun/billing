# == Schema Information
#
# Table name: billing_manager_owners
#
#  id          :uuid             not null, primary key
#  parent_type :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  parent_id   :string           not null
#  stripe_id   :string           not null
#
module BillingManager
  class Owner < ApplicationRecord
    belongs_to(:parent, polymorphic: true)
    encrypts(:stripe_id)
    has_many(:features)
    has_many(:bundles)
    has_many(:customers)
  end
end
