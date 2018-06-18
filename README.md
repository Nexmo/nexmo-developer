# Nexmo Developer

Nexmo Developer is a platform hosting the Nexmo documentation, API reference, SDKs, Tools & Community content.

### Prerequisites

- Ruby 2.5.0 + bundler
- PostgreSQL
- Yarn

### Setup

```
$ git clone git@github.com:Nexmo/nexmo-developer.git
$ cd nexmo-developer
$ cp .env.example .env
$ bundle install
$ rake db:create
$ rake db:migrate
$ ./bin/yarn install
$ rails s
```

You should now be able to see the site on http://localhost:3000/

### Setting up with Docker

If you don't want to install Ruby & PostgreSQL then you can use docker to sandbox Nexmo Developer into its own containers. After you [Install Docker](https://docs.docker.com/engine/installation/) run the following:

```
$ git clone git@github.com:Nexmo/nexmo-developer.git
$ cd nexmo-developer
$ cp .env.example .env

# Start the web server
$ docker-compose up

# Open the browser (takes about ~30 seconds for the first load)
$ open http://localhost:3000
```

To stop the server cleanly run:

```
$ docker-compose down
```

### Features

- A powerful markup engine with pipeline (see [this blog post](https://lab.io/articles/2017/02/12/extending-markdown-with-middleware/) for details on how this works).
- Automatically generated navigation based on the contents of `_documentation`.
- Turbolinks for progressively loading content into for a seamless user experience.

### Future Features

- Dynamic content for community section
- Interactive examples of the Nexmo APIs

## Pulling in code from other repos

Some examples require code from repos such as [nexmo-community/nexmo-ruby-quickstart](https://github.com/nexmo-community/nexmo-ruby-quickstart) these repos can be defined in `config/repos.yml` as such:

```
nexmo-community/nexmo-ruby-quickstart: 'master'
```

The code can then be pulled into the `.repo` directory with the following command:

```
$ rake repos:pull

# Docker users run:
# $ docker-compose exec web rake repos:pull
```

To pull a single repo provide the GitHub repo name and optional branch:

```
$ rake repos:pull nexmo-community/nexmo-ruby-quickstart master

# Docker users run:
# $ docker-compose exec web rake repos:pull nexmo-community/nexmo-ruby-quickstart master
```

## Bootstrapping a new section

Each new section requires an overview, guides, building blocks and an API reference. To bootstrap a new section, use the `section:create` `rake` task

```
$ rake section:create "Example Name"

# Docker users run:
# $ docker-compose exec web rake section:create "Example Name"
```

### Pre-Commit hooks

This repository uses Yelp's [Pre-Commit framework](http://pre-commit.com/) for managing shared pre-commit hooks.

These include checks to ensure syntactic validity of XML, JSON and YAML files, as well as unfinished merge conflicts and case conflicts in filenames.

This is optional. See the pre-commit website for installation instructions.

## Troubleshooting

#### I'm having issues with my Docker container

The image may have changed, try rebuild it with the following command:

```
$ docker-compose up --build
```

#### I get an exception `PG::ConnectionBad - could not connect to server: Connection refused` when I try to run the app.

This error indicates that PostgreSQL is not running. If you installed PostgreSQL using `brew` you can get information about how to start it by running:

```
$ brew info postgresql
```

Once PostgreSQL is running you'll need to create and migrate the database. See [Setup](#Setup) for instructions.

## Contributing

Contributions are welcome, please follow [GitHub Flow](https://guides.github.com/introduction/flow/index.html)

## License

The content of this project itself is licensed under the [Creative Commons Attribution 4.0 International license](https://creativecommons.org/licenses/by/4.0/), and the underlying source code used to format and display that content is licensed under the [MIT license](https://github.com/Nexmo/nexmo-developer/blob/master/LICENSE.txt).
