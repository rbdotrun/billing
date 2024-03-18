require 'rails_helper'

module BillingManager
  RSpec.describe BundleItem, type: :model do
    it { is_expected.to belong_to(:bundle) }
  end
end
