Rails.application.routes.draw do

  root "sessions#new"

  get 'new_session' => "sessions#new"
  post 'log_in'  => "sessions#create", :as => "log_in"
  get "log_out" => "sessions#destroy", :as => "log_out"

  resources :users do
    resources :transactions
  	get "squares" => "squares#new"
  	post 'squares'  => "squares#create"
  end




end
