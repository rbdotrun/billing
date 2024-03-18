require 'rails_helper'

module BillingManager
  RSpec.describe Price, type: :model do
    it { is_expected.to belong_to(:feature) }
    it { is_expected.to have_many(:subscription_items) }
    it { is_expected.to have_many(:price_tiers) }

    it { is_expected.to validate_presence_of(:price) }

    describe "if recurring" do
      subject(:price) { build(:price, recurring: true) }

      it { is_expected.to validate_presence_of(:recurring_interval) }
      it { is_expected.to validate_presence_of(:recurring_interval_count) }
    end

    describe "if tiers_mode" do
      subject(:price) { build(:price, tiers_mode: :graduated, price: nil) }

      it { is_expected.not_to validate_presence_of(:price) }
    end
  end
end
