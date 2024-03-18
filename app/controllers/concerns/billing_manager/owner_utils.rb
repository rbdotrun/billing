module BillingManager
  module OwnerUtils
    extend(ActiveSupport::Concern)

    included do
      before_action(:ensure_owner!)
      helper_method(:current_owner)
    end

    def ensure_owner!
      redirect_to(new_owner_path) unless current_owner
    end

    def current_owner
      @current_owner ||= Owner.find_by(parent_type: nil, parent_id: nil)
    end
  end
end