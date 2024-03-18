BillingManager::Engine.routes.draw do
  root(to: "customers#index")
  resource(:owner, except: %i[index destroy show]) do
    resources(:features)
    resources(:customers)
  end
end
