require 'rails_helper'

module BillingManager
  RSpec.describe Price, type: :model do
    it { is_expected.to belong_to(:feature) }
    it { is_expected.to have_many(:subscription_items) }
  end
end
