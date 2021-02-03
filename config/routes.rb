Rails.application.routes.draw do
  get '/api_docs', to: 'swagger_api#index'
  namespace :api do
    namespace :v1 do
      resources :customers
      post 'login', to: 'sessions#create'
      resources :suppliers, only: %i[index show create update]
    end
  end
end
