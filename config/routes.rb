Rails.application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :users, ActiveAdmin::Devise.config

  namespace :feedback do
    resources :feedbacks
  end

  namespace :admin_api, defaults: {format: 'json'} do
    resources :feedback, only: [:index]
  end

  get '/robots.txt', to: 'static#robots'

  get 'markdown/show'

  match '/markdown', to: 'markdown#preview', via: [:get, :post]

  get '/signout', to: 'sessions#destroy'

  post '/jobs/code_example_push', to: 'jobs#code_example_push'
  post '/jobs/open_pull_request', to: 'jobs#open_pull_request'

  get '/stats', to: 'dashboard#stats'

  get '/tutorials', to: 'tutorials#index'
  get '/tutorials/*document(/:code_language)', to: 'tutorials#show', constraints: DocumentationConstraint.code_language
  get '/*product/tutorials', to: 'tutorials#index', constraints: DocumentationConstraint.product_with_parent

  get '/documentation', to: 'static#documentation'

  get '/legacy', to: 'static#legacy'
  get '/team', to: 'static#team'
  resources :careers, only: [:show], path: 'team'

  get '/community/slack', to: 'slack#join'
  post '/community/slack', to: 'slack#invite'

  get '/tools', to: 'static#tools'
  get '/community', to: 'static#community'
  get '/community/past-events', to: 'static#past_events'

  get '/feeds/events', to: 'feeds#events'

  get '/changelog', to: 'changelog#index'
  get '/changelog/:version', to: 'changelog#show', constraints: { version: /\d\.\d\.\d/ }

  match '/search', to: 'search#results', via: [:get, :post]

  get '/api-errors', to: 'api_errors#index'
  get '/api-errors/generic/:id', to: 'api_errors#show'
  get '/api-errors/*definition', to: 'api_errors#index_scoped', as: 'api_errors_scoped', constraints: OpenApiConstraint.products
  get '/api-errors/*definition/:id', to: 'api_errors#show', constraints: OpenApiConstraint.products

  get '/api', to: 'api#index'

  get '/api/*definition(/:code_language)', to: 'open_api#show', as: 'open_api', constraints: OpenApiConstraint.products
  get '/api/*document(/:code_language)', to: 'api#show', constraints: DocumentationConstraint.code_language

  get '/*product/api-reference', to: 'markdown#api'

  scope "(:namespace)", namespace: /contribute/, defaults: { namespace: '' } do
    get '/*document(/:code_language)', to: 'markdown#show', constraints: DocumentationConstraint.documentation
  end

  get '/:product/*document(/:code_language)', to: 'markdown#show', constraints: DocumentationConstraint.documentation

  get '*unmatched_route', to: 'application#not_found'

  root 'static#landing'
end
