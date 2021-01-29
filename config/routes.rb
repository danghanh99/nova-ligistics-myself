Rails.application.routes.draw do
  get '/api_docs', to: 'swagger_api#index'
end
