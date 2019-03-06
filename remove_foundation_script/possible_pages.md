## Pages:Views

### Searched | Fixed?
[x]        []      '/*landing_page', to: 'static#default_landing'

[x]        []      '/signout', to: 'sessions#destroy'

[x]        []      post '/jobs/code_example_push', to: 'jobs#code_example_push'

[x]        []      post '/jobs/open_pull_request', to: 'jobs#open_pull_request'

[x]        []     '/coverage', to: 'dashboard#coverage'

[x]        []     '/stats', to: 'dashboard#stats'

[x]        []     '/stats/summary', to: 'dashboard#stats_summary'

[x]        []     '/tutorials/(:code_language)', to: 'tutorials#index'

[x]        []     '/tutorials/*document(/:code_language)', to: 'tutorials#show'

[x]        []     '/documentation', to: 'static#documentation'

[x]        [x]     /migrate/tropo/(/*guide)', to: 'static#migrate_details'

[x]        []      '/legacy', to: 'static#legacy'

[x]        []      '/team', to: 'static#team'

[x]        []      '/community/slack', to: 'slack#join'

[x]        []      post '/community/slack', to: 'slack#invite'

[x]        []      /tools', to: 'static#tools'

[x]        []      '/community', to: 'static#community'

[x]        []      '/community/past-events', to: 'static#past_events'

[x]        []     '/feeds/events', to: 'feeds#events'

[x]        []      '/extend', to: 'extend#index'

[x]        []      '/extend/:title', to: 'extend#show'

[x]        []      match '/search', to: 'search#results'

[x]        [x]     '/api-errors', to: 'api_errors#index'

[x]        [x]     '/api-errors/generic/:id', to: 'api_errors#show'

[x]        [x]     '/api-errors/*definition', to: 'api_errors#index_scoped'

[x]        []      '/api', to: 'api#index'

[x]        []      '/api/*definition(/:code_language)', to: 'open_api#show'

[x]        []      '/task/(:task_name)(/*task_step)(/:code_language)', to: 'task#index'

[x]        []      '/*product/api-reference', to: 'markdown#api'

[x]        []      /contribute, to: 'markdown#show'

[x]        []     '*unmatched_route', to: 'application#not_found'

[x]        []      root 'static#landing'