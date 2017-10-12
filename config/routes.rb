Rails.application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :users, ActiveAdmin::Devise.config

  namespace :feedback do
    resources :feedbacks
  end

  get 'markdown/show'

  get '/tutorials', to: 'tutorials#index'
  get '/tutorials/*document(/:code_language)', to: 'tutorials#show', constraints: DocumentationConstraint.code_language
  get '/*product/tutorials', to: 'tutorials#index', constraints: DocumentationConstraint.product_with_parent

  get '/documentation', to: 'static#documentation'

  get '/contribute', to: 'static#contribute'
  get '/contribute/styleguide', to: 'static#styleguide'
  get '/contribute/write-the-docs', to: 'static#write_the_docs'

  get '/legacy', to: 'static#legacy'

  get '/community/slack', to: 'slack#join'
  post '/community/slack', to: 'slack#invite'

  get '/tools', to: 'static#tools'
  get '/community', to: 'static#community'
  get '/community/past-events', to: 'static#past_events'

  get '/feeds/events', to: 'feeds#events'

  get '/changelog', to: 'changelog#index'
  get '/changelog/:version', to: 'changelog#show', constraints: { version: /\d\.\d\.\d/ }

  match '/search', to: 'search#results', via: [:get, :post]

  get '/api', to: 'api#index'

  get '/api/*specification(/:code_language)', to: 'open_api#show', as: 'open_api', constraints: { specification: /example/ }
  get '/api/*document(/:code_language)', to: 'api#show', constraints: DocumentationConstraint.code_language

  get '/*product/(api|ncco)-reference', to: 'markdown#api'
  get '/:product/*document(/:code_language)', to: 'markdown#show', constraints: DocumentationConstraint.documentation

  get '/robots.txt', to: 'static#robots'

  get '/signout', to: 'sessions#destroy'

  post '/jobs/code_example_push', to: 'jobs#code_example_push'
  post '/jobs/open_pull_request', to: 'jobs#open_pull_request'

  get '*unmatched_route', to: 'application#not_found'

  root 'static#landing'
end
