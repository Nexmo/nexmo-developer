# Nexmo OAS Renderer

![Build Status](https://github.com/Nexmo/nexmo-oas-renderer/workflows/CI/badge.svg)
[![MIT licensed](https://img.shields.io/badge/license-MIT-blue.svg)](./LICENSE.txt)

Sinatra application that provides a preview of how the OAS documents will be rendered within [Nexmo Developer](https://developer.nexmo.com/).

* [Dependencies](#requirements)
* [Installation and Usage](#installation-and-usage)
    * [Using Docker](#using-docker)
    * [As a standalone application](#as-a-standalone-application)
    * [Mounted into a Rails application](#mounted-into-a-rails-application)
    * [Specifying the path to the documents](#specifying-the-path-to-the-documents)
* [Contributing](#contributing)
* [License](#license)

## Dependencies


## Installation and Usage

### Using Docker

You can run using Docker and it will serve the current directory (this will usually be the api-specification repo):

#### Mac/Linux

```bash
docker run --rm -p 4567:4567 -v `pwd`:/definitions -e 'OAS_PATH=/definitions' nexmodev/nexmo-oas-renderer:latest
```

Alternatively, add the following to your `~/.bashrc` file and you'll be able to run `nexmo-oas-renderer`

```
function nexmo-oas-renderer() {
  docker run --rm -p 4567:4567 -v `pwd`:/definitions -e 'OAS_PATH=/definitions' nexmodev/nexmo-oas-renderer:latest
}
```

#### Windows

```ps
docker run --rm -p 4567:4567 -v %CD%:/definitions -e 'OAS_PATH=/definitions' nexmodev/nexmo-oas-renderer:latest
```

### As a standalone application

Install the gem:

``` shell
$ gem install nexmo-oas-renderer
```

And simply run the executable with the corresponding env variables set (see [Note](#note)):
``` shell
$ nexmo-oas-renderer
```

Or, if you want to make code changes, just run the following command which will start the web server on http://localhost:9393:
``` shell
OAS_PATH=... bundle exec shotgun lib/nexmo/oas/renderer/config.ru
```

### Mounted into a Rails Application

Add this to your application's `Gemfile`:

```
gem 'nexmo-oas-renderer', require: false
```

And then run `bundle install`.

Require the gem in `config/environment.rb` as follows:

``` ruby
# Load the Rails application.
require_relative 'application'

require 'nexmo/oas/renderer'

# Initialize the Rails application.
Rails.application.initialize!
```

And finally mount the Sinatra app into your Rails application by adding the following line to `config/routes.rb`:

``` ruby
mount Nexmo::OAS::Renderer::API, at: '/api'
```

### Specifying the path to the documents

This gem uses [dotenv](https://github.com/bkeepers/dotenv) to handle environment variables, so you should copy the `.env.example` provided by running:
``` shell
$ cp .env.example .env
```
and assign values to the corresponding variables.

#### Note
The env variable `OAS_PATH` indicates the path to the documents that will be rendered.

## Contributing
We ❤️ contributions from everyone! [Bug reports](https://github.com/Nexmo/nexmo-oas-renderer/issues), [bug fixes](https://github.com/Nexmo/nexmo-oas-renderer/pulls) and feedback on the library is always appreciated. Look at the [Contributor Guidelines](https://github.com/Nexmo/nexmo-oas-renderer/blob/master/CONTRIBUTING.md) for more information and please follow the [GitHub Flow](https://guides.github.com/introduction/flow/index.html).

## License
This project is under the [MIT LICENSE](https://github.com/Nexmo/nexmo-oas-renderer/blob/master/LICENSE).
