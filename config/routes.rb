Rails.application.routes.draw do

  root "sessions#new"

  get 'new_session' => "sessions#new"
  post 'log_in'  => "sessions#create", :as => "log_in"
  get "log_out" => "sessions#destroy", :as => "log_out"

  resources :users do
    resources :transactions
    resources :groups, except: [:destroy] do
      resources :user_squarings, only: [:index, :new, :show, :create]
    end
    resources :user_squarings, only: [:index, :create, :new, :show]
  end
end
