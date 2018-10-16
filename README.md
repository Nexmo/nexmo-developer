# Nexmo Developer

<p><a href='#contributions'>Contributions</a> &middot; <a href='#testing'>Testing</a> &middot; <a href='#running-locally'>Running Locally</a> &middot; <a href='#admin-dashboard'>Admin Dashboard</a> &middot; <a href='#troubleshooting'>Troubleshooting</a></p>

This repository is the code and content for <https://developer.nexmo.com>, which includes the Nexmo documentation, API reference, SDKs, Tools & Community content.
        
## Contributions

We welcome contributions from everyone! Look at the [Contributor Guidelines](CONTRIBUTING.md) for more information, and please follow the [GitHub Flow](https://guides.github.com/introduction/flow/index.html).

## Testing

We use [rspec](http://rspec.info/) to test Nexmo Developer.

To run all tests:

```bash
bundle exec rspec
```

To generate code coverage, set the `COVERAGE` environment variable when running the tests.

```bash
COVERAGE=1 bundle exec rspec
```

This will create a folder named `coverage`. Open `index.html` in this folder to view coverage statistics.

## Running locally

The project can be run on your laptop, either directly or using Docker. These instructions have been tested for mac.

### Setup for running directly on your laptop

Before you start, you will need to make sure that you have:

- [Ruby 2.5.1](https://www.ruby-lang.org/en/downloads/) + [bundler](https://bundler.io/)
- [PostgreSQL](https://www.postgresql.org/download/)
- [Yarn](https://yarnpkg.com/en/docs/install)

To set up the project, clone this project and configure your settings:

```
$ git clone git@github.com:Nexmo/nexmo-developer.git
$ cd nexmo-developer
$ cp .env.example .env
```

Edit the `.env` file as appropriate for your platform.  Then, run the following:

```
$ bundle install
$ rake db:create
$ rake db:migrate
$ rake db:seed
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
```

Edit the `.env` file as appropriate for your platform.  Then, start the web server with this command:

```
$ docker-compose up
```

At this point, open your browser to http://localhost:3000/ ... and wait (it takes about 30 seconds for the first load).

To stop the server cleanly run:

```
$ docker-compose down
```

## Admin dashboard

You can access the admin dashboard by visiting `/admin`. If you've populated data via `rake db:seed` you will have an admin user with the username of `admin@nexmo.com` and password of `development`.

The following is an example if you are running Nexmo Developer within a Docker container:

```sh
docker exec -it <container_id> rake db:seed
```

New admin users can be created by visiting `/admin/users` or by accessing the rails console and creating a new User like so:

```ruby
User.create!(email: 'example@example.com', password: 'password', admin: true)
```

## Troubleshooting

#### I'm having issues with my Docker container

The image may have changed, try rebuilding it with the following command:

```
$ docker-compose up --build
```

#### I get an exception `PG::ConnectionBad - could not connect to server: Connection refused` when I try to run the app.

This error indicates that PostgreSQL is not running. If you installed PostgreSQL using `brew` you can get information about how to start it by running:

```
$ brew info postgresql
```

Once PostgreSQL is running you'll need to create and migrate the database. See [Setup](#Setup) for instructions.
