# System Overview

Nexmo Developer is a simple Rails application with a mounted Sinatra app that handles the rendering of the [API References](https://developer.nexmo.com/api).

# Deployment

NDP is hosted in Heroku and is automatically deployed every time a branch is merged into master via a Github integration.
In case you want to force a deploy, you can always deploy NDP from [Heroku's dashboard](https://dashboard.heroku.com/apps/nexmo-developer).

## Required Resources

* Heroku Redis: Used for caching view fragments and resources, its configuration can be found in [production.rb](https://github.com/Nexmo/nexmo-developer/blob/adab0ed5ef9ca61a5be14481cbb6c0a50af0ab11/config/environments/production.rb#L59-L65).
* Heroku Scheduler: Runs a scheduled job everyday at 5pm that refreshes Algolia's indexes.
* Heroku Postgres: SQL Database service.
* Algolia: In Production, the search form is enabled and it is powered by [Algolia](https://www.algolia.com/).

# How to diagnose problems with NDP

## Logs

We use [Logz.io](https://logz.io/) as a logging solution with a 3Gb daily volume and 3 days retention plan, as an alternative you can always check Heroku's logs which expire after one week. 

## Error Monitoring and Reporting

We use [Bugsnag](https://www.bugsnag.com/) for monitoring errors both on the Backend and Frontend splitted into different Projects.
Bare in mind that most of the errors are logged under `Markdown#show` so it might take a while to find a specific error.

## Health checks

We use [Pingdom](https://www.pingdom.com/) to monitor [NDP's](https://developer.nexmo.com) health, and email notifications are sent when the site is Down/Up.

## Caching

We currently cache the sidenav and the information we fetch from Greenhouse in order to render the careers page. The cache is cleared as part of the deploy process, so when facing a caching issue, just trigger a new deploy or run the following rake task in Heroku `rake cache:clear`.

# Available configuration options

## Configuration management

When running NDP locally, `dotenv` loads the corresponding environment variables from `.env` to ENV. However, when the app is deployed to Heroku the evnvironment variables are set in Heroku's dashboard.

## Enabling Search locally

To enable the Search form locally, the `ALGOLIA_SEARCH_KEY` environment variable needs to be set, the rest of the configuration is defined in `config/algolia.yml`

# Common issues when running NDP locally

NDP can be run locally either directly or using Docker, for more information about how to run it see the [Readme](https://github.com/Nexmo/nexmo-developer/blob/master/README.md#running-locally). When using docker, re-building the image should fix the following issues

* `Could not find definition '<insert_file_here>' in '<path>'`: set the right `OAS_PATH`  in `.env`, check `.env.example` for the default value.

* `Error connecting to Redis on localhost:6379`: you are seeing this error becase the `REDIS_URL` env variable is set and the app couldn't connect to it. Make sure redis is up and running and re-start the app server.

* Migration errors: run `bundle exec rake db:migrate`

* While running `bundle install`:
  * `ruby version '<version>' is not installed`:  try running `rbenv install <version> && gem install bundler` followed by `bundle install`

* Webpacker errors:
    * `The engine "node" is incompatible with this module. Expected version...` We use [nvm](https://github.com/nvm-sh/nvm) as node's version manage, check that the right version of node is installed (specified in `.nvmrc`) and run `nvm use <version>`.
    * Make sure that all the packages are install by running `yarn install`