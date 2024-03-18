module BillingManager
  class OwnersController < ApplicationController
    before_action(:ensure_owner!, except: %i[new create])

    def create
      @owner = Owner.create(owner_params)
      redirect_to(root_path)
    end

    def update
      current_owner.update(owner_params)
    end

    private

    def owner_params
      params.require(:owner).permit(
        :stripe_secret_key, :stripe_publishable_key,
      )
    end
  end
end