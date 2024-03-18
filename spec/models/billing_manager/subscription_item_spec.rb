require 'rails_helper'

module BillingManager
  RSpec.describe SubscriptionItem, type: :model do
    subject(:subscription_item) { build(:subscription_item) }

    it { is_expected.to belong_to(:subscription) }
    it { is_expected.to belong_to(:price) }

    it { is_expected.to validate_uniqueness_of(:price_id).scoped_to(:subscription_id).case_insensitive }
  end
end
