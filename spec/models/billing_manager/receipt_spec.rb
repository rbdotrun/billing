require 'rails_helper'

module BillingManager
  RSpec.describe Receipt, type: :model do
    it { is_expected.to belong_to(:subscription) }
  end
end
