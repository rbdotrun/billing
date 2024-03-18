require 'rails_helper'

module BillingManager
  RSpec.describe PriceTier, type: :model do
    it { is_expected.to belong_to(:price) }
  end
end
