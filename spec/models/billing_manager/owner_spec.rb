require 'rails_helper'

module BillingManager
  RSpec.describe Owner, type: :model do
    it { is_expected.to belong_to(:parent) }
    it { is_expected.to have_many(:features) }
    it { is_expected.to have_many(:bundles) }
    it { is_expected.to have_many(:customers) }
  end
end
