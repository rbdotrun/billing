require 'rails_helper'

module BillingManager
  RSpec.describe Feature, type: :model do
    it { is_expected.to belong_to(:owner) }
    it { is_expected.to have_many(:prices) }
  end
end
