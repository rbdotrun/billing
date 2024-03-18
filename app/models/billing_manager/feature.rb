# == Schema Information
#
# Table name: billing_manager_features
#
#  id          :uuid             not null, primary key
#  active      :boolean          default(FALSE), not null
#  description :text
#  label       :string           not null
#  stripe_data :jsonb
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  owner_id    :uuid
#  stripe_id   :string
#
# Indexes
#
#  index_billing_manager_features_on_owner_id   (owner_id)
#  index_billing_manager_features_on_stripe_id  (stripe_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (owner_id => billing_manager_owners.id)
#
module BillingManager
  class Feature < ApplicationRecord
    belongs_to(:owner)
    has_many(:prices, dependent: :destroy)
    has_one_attached(:visual)
    validates(:label, presence: true)
  end
end
