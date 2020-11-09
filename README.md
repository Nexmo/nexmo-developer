# Vonage API Developer Portal

[![Build Status](https://api.travis-ci.org/Nexmo/nexmo-developer.svg?branch=master)](https://travis-ci.org/Nexmo/nexmo-developer/)
[![MIT licensed](https://img.shields.io/badge/license-MIT-blue.svg)](./LICENSE.txt)

This repository is the content for <https://developer.nexmo.com>, which includes the Vonage documentation, API reference, SDKs, Tools & Community content. To get a Vonage account, sign up [for free at nexmo.com][signup].

### [Testing](#testing) &middot; [Running Locally](#running-locally) &middot; [Admin Dashboard](#admin-dashboard) &middot; [Troubleshooting](#troubleshooting) &middot; [Contributing](#contributing) &middot; [License](#license)




## Testing

### Spell Checking

We write the docs in US English and enforce this at build time with a CI check. You can run the check locally using the following command:

```
./node_modules/.bin/mdspell -r -n -a --en-us '_documentation/en/**/*.md' '_partials/*.md' '_partials/**/*.md' '_modals/**/*.md' '_tutorials/**/*.md'
```

Or if you're using Docker:

```
docker-compose exec web ./node_modules/.bin/mdspell -r -n -a --en-us '_documentation/en/**/*.md' '_partials/*.md' '_partials/**/*.md' '_modals/**/*.md' '_tutorials/**.md'
```

If there is a word that isn't in the dictionary but is correct to use, add it to the `.spelling` file (there's a lot of exceptions in there, including `Vonage`!)

## Running locally

The project can be run on your laptop, either directly or using Docker. These instructions have been tested for Mac.

### Setup for running directly on your laptop

Before you start, you need to make sure that you have:

- [Ruby 2.5.8](https://www.ruby-lang.org/en/downloads/) + [bundler](https://bundler.io/)
- [PostgreSQL](https://www.postgresql.org/download/)
- [Yarn](https://yarnpkg.com/en/docs/install)

#### System Setup (OSX)

Install Homebrew

```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

Install required packages, create database and configure `git`.

Note: A default database is created for you when you run the `db:setup` script. If you'd like to create and
use a different database or user, use `createdb database_name_here` or `createuser username_here` and make sure your
`.env` file is updated accordingly (See [.env.example](https://github.com/Nexmo/nexmo-developer/blob/master/.env.example)).

```bash
brew install postgres rbenv git yarn nvm redis
brew services start postgresql
brew services start redis


git config --global user.name "NAME"
git config --global user.email "user.name@vonage.com"
```

Generate an SSH key for authentication

```bash
ssh-keygen -t rsa
cat .ssh/id_rsa.pub # Add to GitHub
```

Clone ADP to your local machine

```bash
git clone git@github.com:Nexmo/nexmo-developer.git
cd nexmo-developer
cp .env.example .env
```

Install the correct versions of ruby
```
rbenv install 2.5.8
rbenv global 2.5.8
gem install bundle
bundle install
```

Edit the `.env` file as appropriate for your platform.  Then, run the following:

```bash
bundle exec nexmo-developer --docs=`pwd`
```

You should now be able to see the site on http://localhost:3000/

### Setting up with Docker

If you don't want to install Ruby & PostgreSQL then you can use docker to sandbox the Vonage API Developer Portal into its own containers. After you [Install Docker](https://docs.docker.com/engine/installation/) run the following:

```sh
$ git clone git@github.com:Nexmo/nexmo-developer.git
$ cd nexmo-developer
```

```bash
$ docker-compose up
```

Once `docker-compose up` has stopped returning output, open a new terminal and run `docker-compose run web bundle exec rake db:migrate`.

At this point, open your browser to http://localhost:3000/ and you should see the homepage. The first time you click on `Documentation` it might take 5 seconds or so, but any further page loads will be almost instantaneous.

To stop the server press `ctrl+c`.

> If you get an error that says "We're sorry, but something went wrong." you might need to run the database migrations with `docker-compose run web bundle exec rake db:migrate`

## Admin dashboard

You can access the admin dashboard by visiting `/admin`. Initially, you will have an admin user with the username of `api.admin@vonage.com` and password of `development`.

The following is an example if you are running the Vonage API Developer Portal within a Docker container:

```sh
docker exec -it <container_id> rake db:seed
```

New admin users can be created by visiting `/admin/users`.

## Working with submodules

Some of the contents of ADP are brought in via git submodules, such as the OpenAPI Specification (OAS) documents. A submodule is a separate repository used within the main repository (in this case ADP) as a dependency. The main repository holds information about the location of the remote repository and **which commit to reference**. So to make a change within a submodule, you need to commit to the submodule and the main repository and crucially remember to push both sets of changes to GitHub.

Here are some tips for working with submodules:

### When cloning the repo or starting to work with submodules

```bash
git submodule init
git submodule update
```

### When pulling in changes to a branch e.g. updating master

```bash
git pull
git submodule update
```

### When making changes inside the submodule within ADP

Make sure you are _inside_ the directory that is a submodule.

- make your changes
- commit your changes
- _push your changes from here_ (this is the bit that normally trips us up)
- open a pull request on the submodule's repository - we can't open the PR on the main repo until this is merged

You are not done, keep reading! A second pull request is needed to update the main repo, including any other changes to that repo _and_ an update to the submodule pointing to the new (merged) commit to use.

- open your PR for this change including any changes to the main project (so we don't lose it) but label it "don't merge" and add the URL of the submodule PR we're waiting for
- once the submodule has the change you need on its master branch, change into the subdirectory and `git pull`
- change directory back up to the root of the project
- commit the submodules changes
- _push these changes too_
- Now we can review your PR


### Bringing submodule changes into ADP

If you made changes on the repo outside of ADP, then you will need to come and make a commit on ADP to update which commit in the submodule the ADP repository is pointing to.

Make a branch, change into the submodule directory and `git pull` or do whatever you need to do to get `HEAD` pointing to the correct commit. In the top level of the project, add the change to the submodules file and commit and push. Then open the pull request as you would with any other changes.

### Further advice and resources for successful submodule usage

Never `git add .` this will make bad things happen with submodules.  Try `git add -p` instead. You're welcome.

If you're not sure what to do, ask for help. It's easier to lend a hand along the way than to rescue it later!

Git docs for submodules: <https://git-scm.com/book/en/v2/Git-Tools-Submodules>

A flow chart on surviving submodules from @lornajane: <https://lornajane.net/posts/2016/surviving-git-submodules>

## Troubleshooting

#### I'm having issues with my Docker container

The image may have changed, try rebuilding it with the following command:

```bash
$ docker-compose up --build
```

#### I get an exception `PG::ConnectionBad - could not connect to server: Connection refused` when I try to run the app.

This error indicates that PostgreSQL is not running. If you installed PostgreSQL using `brew` you can get information about how to start it by running:

```bash
$ brew info postgresql
```

Once PostgreSQL is running you'll need to create and migrate the database. See [Setup](#running-locally) for instructions.

## Upgrading Volta

Volta is the Vonage design system, and is used to style the Vonage API Developer Portal. To upgrade the version of Volta used:

* Clone Volta on to your local machine
* Remove the `app/assets/volta/scss` folder in the Vonage API Developer Portal
* Copy the `scss` folder from the Volta repo in to `app/assets/volta`
* Commit and push. Rails will take care of compilation etc

## Contributing
We :heart: contributions from everyone! It is a good idea to [talk to us](https://nexmo-community-invite.herokuapp.com/) first if you plan to add any new functionality. Otherwise, [bug reports](https://github.com/Nexmo/nexmo-developer/issues/), [bug fixes](https://github.com/Nexmo/nexmo-developer/pulls) and feedback on the library are always appreciated. Look at the [Contributor Guidelines](CONTRIBUTING.md) for more information and please follow the [GitHub Flow](https://guides.github.com/introduction/flow/index.html).

## [![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/dwyl/esta/issues) [![GitHub contributors](https://img.shields.io/github/contributors/Nexmo/nexmo-developer.svg)](https://GitHub.com/Nexmo/nexmo-developer/graphs/contributors/)

## Content Updates

Follow these instructions to make updates to any content in the Vonage API Developer Portal repository.

Checkout a new branch, naming it appropriately:

```bash
git checkout -b your-branch-name
```

Locate the file containing the content you wish to update in `_documentation/en` and open it in your preferred editor. The URL on the documentation site translates to the file path in `_documentation/en`.

Make and save the necessary updates in the file.

Add your changes:

```bash
git add -p
```

Commit the changes in your branch. Include a commit message adequately describing the update(s):

```bash
git commit -m “Add a commit message”
```

Push your branch in order to raise a pull request:

```bash
git push origin your-branch-name
```

Create a pull request in GitHub:

1. In the `nexmo-developer` repository, click the Pull requests tab.
2. Click the Compare and new pull request button next to your branch in the list. 
3. Review the changes between your branch and master.
4. Add a Description of the changes.
5. Click the Create pull request button.

## License

This library is released under the [MIT License][license]

[signup]: https://dashboard.nexmo.com/sign-up?utm_source=DEV_REL&utm_medium=github&utm_campaign=nexmo-developer
[license]: LICENSE.txt
