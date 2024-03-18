require 'rails_helper'

module BillingManager
  RSpec.describe Bundle, type: :model do
    it { is_expected.to belong_to(:owner) }
    it { is_expected.to have_many(:bundle_items) }
  end
end
