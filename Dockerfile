# Base image:
FROM ruby:2.4.1

# Install dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev lsof

# Install modern NodeJS
run curl -sL https://deb.nodesource.com/setup_8.x | bash -
run apt-get update && apt-get install -y nodejs

# Set an environment variable where the Rails app is installed to inside of Docker image:
RUN mkdir -p /app/.git/hooks
WORKDIR /app

ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle install
ADD . /app
