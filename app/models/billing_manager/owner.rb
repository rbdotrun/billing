# == Schema Information
#
# Table name: billing_manager_owners
#
#  id                     :uuid             not null, primary key
#  parent_type            :string
#  stripe_publishable_key :string           not null
#  stripe_secret_key      :string           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  parent_id              :string
#
module BillingManager
  class Owner < ApplicationRecord
    belongs_to(:parent, polymorphic: true, optional: true)
    encrypts(:stripe_publishable_key)
    encrypts(:stripe_secret_key)

    with_options(dependent: :destroy) do
      has_many(:features)
      has_many(:bundles)
      has_many(:customers)
    end

    validates(:parent_type, uniqueness: { scope: :parent_id, case_sensitive: false })
    validates(:stripe_publishable_key, :stripe_secret_key, presence: true)
  end
end
