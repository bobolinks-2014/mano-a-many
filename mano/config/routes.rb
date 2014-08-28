Rails.application.routes.draw do

  root "users#index"
    
  get 'new_session' => "sessions#new"
  get 'log_in'  => "sessions#create", :as => "log_in"
  get "log_out" => "sessions#destroy", :as => "log_out"

  resources :users do
    resources :transactions
  end


end
