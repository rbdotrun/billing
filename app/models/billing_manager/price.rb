# == Schema Information
#
# Table name: billing_manager_prices
#
#  id                       :uuid             not null, primary key
#  label                    :string           not null
#  price                    :float            not null
#  recurring                :boolean          default(FALSE), not null
#  recurring_interval       :integer
#  recurring_interval_count :integer
#  stripe_data              :jsonb
#  usage_type               :enum             default("licensed"), not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  feature_id               :uuid
#  stripe_id                :string
#
# Indexes
#
#  index_billing_manager_prices_on_feature_id  (feature_id)
#
# Foreign Keys
#
#  fk_rails_...  (feature_id => billing_manager_features.id)
#
module BillingManager
  class Price < ApplicationRecord
    belongs_to(:feature)
    has_many(:subscription_items)
    validates(:recurring, :recurring_interval, :recurring_interval_count, presence: true, if: -> { recurring })
  end
end
