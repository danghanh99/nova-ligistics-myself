Rails.application.routes.draw do
  get '/api_docs', to: 'swagger_api#index'
  namespace :api do
    namespace :v1 do
      post 'login', to: 'sessions#create'
    end
  end
end
