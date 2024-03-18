require 'rails_helper'

module BillingManager
  RSpec.describe Owner, type: :model do
    subject(:owner) { build(:owner) }

    it { is_expected.to belong_to(:parent).optional }
    it { is_expected.to have_many(:features) }
    it { is_expected.to have_many(:bundles) }
    it { is_expected.to have_many(:customers) }

    it { is_expected.to validate_uniqueness_of(:parent_type).scoped_to(:parent_id).case_insensitive }
  end
end
