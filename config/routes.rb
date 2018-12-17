Rails.application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :users, ActiveAdmin::Devise.config

  namespace :feedback do
    resources :feedbacks
  end

  namespace :usage do
    resources :building_block
  end

  namespace :admin_api, defaults: { format: 'json' } do
    resources :feedback, only: [:index]
  end

  get '/robots.txt', to: 'static#robots'

  get 'markdown/show'

  get '/signout', to: 'sessions#destroy'

  post '/jobs/code_example_push', to: 'jobs#code_example_push'
  post '/jobs/open_pull_request', to: 'jobs#open_pull_request'

  get '/coverage', to: 'dashboard#coverage'
  get '/stats', to: 'dashboard#stats'
  get '/stats/summary', to: 'dashboard#stats_summary'

  get '/tutorials/(:code_language)', to: 'tutorials#index', constraints: DocumentationConstraint.code_language
  get '/tutorials/*document(/:code_language)', to: 'tutorials#show', constraints: DocumentationConstraint.code_language
  get '/*product/tutorials(/:code_language)', to: 'tutorials#index', constraints: lambda { |request|
    products = DocumentationConstraint.product_with_parent_list

    # If there's no language in the URL it's an implicit match
    includes_language = true

    # If there's a language in the URL, match on that too
    if request['code_language']
      language = DocumentationConstraint.code_language_list.map(&:downcase)
      includes_language = language.include?(request['code_language'])
    end

    products.include?(request['product']) && includes_language
  }

  get '/documentation', to: 'static#documentation'

  get '/hansel', to: 'static#podcast'

  get '/spotlight', to: 'static#developer_spotlight'

  get '/migrate/tropo', to: 'static#migrate'
  get '/migrate/tropo/(/*guide)', to: 'static#migrate_details'

  get '/legacy', to: 'static#legacy'
  get '/team', to: 'static#team'
  resources :careers, only: [:show], path: 'team'

  get '/community/slack', to: 'slack#join'
  post '/community/slack', to: 'slack#invite'

  get '/tools', to: 'static#tools'
  get '/community', to: 'static#community'
  get '/community/past-events', to: 'static#past_events'

  get '/feeds/events', to: 'feeds#events'

  get '/extend', to: 'extend#index'
  get '/extend/:title', to: 'extend#show'

  match '/search', to: 'search#results', via: %i[get post]

  get '/api-errors', to: 'api_errors#index'
  get '/api-errors/generic/:id', to: 'api_errors#show'
  get '/api-errors/*definition', to: 'api_errors#index_scoped', as: 'api_errors_scoped', constraints: OpenApiConstraint.products
  get '/api-errors/*definition/:id', to: 'api_errors#show', constraints: OpenApiConstraint.products

  get '/api', to: 'api#index'

  # Show the old /verify/templates page
  get '/api/*definition/*code_language', to: 'api#show', constraints: lambda { |request|
    request['definition'] == 'verify' && request['code_language'] == 'templates'
  }

  get '/api/*definition(/:code_language)', to: 'open_api#show', as: 'open_api', constraints: OpenApiConstraint.products
  get '/api/*document(/:code_language)', to: 'api#show', constraints: DocumentationConstraint.code_language

  get '/*product/api-reference', to: 'markdown#api'

  scope '(:namespace)', namespace: /contribute/, defaults: { namespace: '' } do
    get '/*document(/:code_language)', to: 'markdown#show', constraints: DocumentationConstraint.documentation
  end

  get '/:product/*document(/:code_language)', to: 'markdown#show', constraints: DocumentationConstraint.documentation

  get '*unmatched_route', to: 'application#not_found'

  root 'static#landing'
end
