Rails.application.routes.draw do
  
resources :users do
  resources :transactions
end

root "users#index"

end
