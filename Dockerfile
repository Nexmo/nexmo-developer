# Base image:
FROM ruby:2.5.5

# Install dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev lsof

# Install modern NodeJS
run curl -sL https://deb.nodesource.com/setup_8.x | bash -
run curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
run echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
run apt-get update && apt-get install -y nodejs yarn

# Set an environment variable where the Rails app is installed to inside of Docker image:
RUN mkdir -p /app/.git/hooks

WORKDIR /app

# Install Node Dependencies
ADD package.json yarn.lock /app/
RUN yarn install

# Update Bundler to Version 2 as ruby:2.5.5 defaults to an older version
RUN gem update --system && gem install bundler

# Install Ruby Dependencies
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle install
