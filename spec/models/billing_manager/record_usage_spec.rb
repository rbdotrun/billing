require 'rails_helper'

module BillingManager
  RSpec.describe RecordUsage, type: :model do
    it { is_expected.to belong_to(:subscription_item) }
  end
end
