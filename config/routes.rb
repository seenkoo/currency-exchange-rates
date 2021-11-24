Rails.application.routes.draw do
  namespace :admin do
    resource :exchange_rate, only: %i[edit update]
    get '/', to: 'exchange_rates#edit'
    get '/exchange_rate', to: 'exchange_rates#edit'
  end

  root 'pages#index'

  require 'sidekiq/web'
  require 'sidekiq-scheduler/web'
  mount Sidekiq::Web => '/sidekiq'
end
