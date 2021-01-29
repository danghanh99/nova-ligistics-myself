Rails.application.routes.draw do
  get '/api_docs', to: 'swagger_api#index'
  namespace :api do
    namespace :v1 do
      resources :customers
    end
  end
end
