require 'rails_helper'

module BillingManager
  RSpec.describe Subscription, type: :model do
    it { is_expected.to have_many(:subscription_items) }
    it { is_expected.to have_many(:receipts) }
  end
end
