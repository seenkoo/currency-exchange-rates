Rails.application.routes.draw do
  root 'pages#index'
  
  require 'sidekiq/web'
  require 'sidekiq-scheduler/web'
  mount Sidekiq::Web => '/sidekiq'
end
