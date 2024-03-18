Rails.application.routes.draw do
  mount BillingManager::Engine => "/billing_manager"
end
