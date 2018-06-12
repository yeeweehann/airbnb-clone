Rails.application.routes.draw do
  root 'front#index'
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]
  resources :listings, controller: "listings"

  resources :users, controller: "clearance/users", only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end
  
  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"
  get "/create_listings" => "listings#new", as: "create_listings"
  post "/listings/:id/verified" => "listings#verified", as: "verify_listing"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
