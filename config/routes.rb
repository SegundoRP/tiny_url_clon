Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root 'shortened_urls#new'

  resources :shortened_urls, only: %i[new create]

  get '/:token' => 'shortened_urls#redirect', as: :redirect
  get '/:token/info' => 'shortened_urls#info', as: :shortened_url_info
end
