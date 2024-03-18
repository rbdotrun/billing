module BillingManager
  class ApplicationController < ActionController::Base
    include(OwnerUtils)
  end
end
