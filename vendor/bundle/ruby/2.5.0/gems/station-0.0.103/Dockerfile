FROM ruby:2.7.2-alpine AS build-env
ARG RAILS_ROOT=/station
ARG BUILD_PACKAGES="build-base curl-dev git"
ARG DEV_PACKAGES="postgresql-dev yaml-dev zlib-dev nodejs yarn"
ARG RUBY_PACKAGES="tzdata"
ENV RAILS_ENV=production
ENV NODE_ENV=production
ENV BUNDLE_APP_CONFIG="$RAILS_ROOT/.bundle"

WORKDIR $RAILS_ROOT

# Install build packages
RUN apk update \
    && apk upgrade \
    && apk add --update --no-cache $BUILD_PACKAGES $DEV_PACKAGES $RUBY_PACKAGES
COPY lib/nexmo_developer/Gemfile* package.json yarn.lock $RAILS_ROOT/

# Upgrade Bundler to version 2
RUN bundle config --global frozen 1 \
    && gem update --system \
    && gem install bundler

RUN bundle install --without development:test:assets -j4 --retry 3 --path=vendor/bundle \
    # Remove unneeded files (cached *.gem, *.o, *.c)
    && rm -rf vendor/bundle/ruby/2.7.0/cache/*.gem \
    && find vendor/bundle/ruby/2.7.0/gems/ -name "*.c" -delete \
    && find vendor/bundle/ruby/2.7.0/gems/ -name "*.o" -delete

# Install node dependencies
RUN yarn install --frozen-lockfile

# Copy the app in to /station and compile assets
COPY lib/nexmo_developer/ $RAILS_ROOT/
RUN bundle exec rake assets:precompile

## Remove folders not needed in resulting image
RUN rm -rf node_modules tmp/cache vendor/assets spec

################ Build step done ###############
FROM ruby:2.7.2-alpine
ARG RAILS_ROOT=/station

ENV RACK_ENV production
ENV RAILS_ENV production
ENV RAILS_SERVE_STATIC_FILES true
ENV RAILS_LOG_TO_STDOUT true
ENV DISABLE_SSL 1
ENV DOCS_BASE_PATH /docs
ENV OAS_PATH /docs/_open_api/api_specs/definitions

ENV BUNDLE_APP_CONFIG="$RAILS_ROOT/.bundle"
WORKDIR $RAILS_ROOT

# Install packges needed at runtime
RUN apk update \
    && apk upgrade \
    && apk add --update --no-cache tzdata postgresql-client nodejs

# Upgrade Bundler to version 2
RUN bundle config --global frozen 1 \
    && gem update --system \
    && gem install bundler

# Copy app with prebuilt assets
COPY --from=build-env $RAILS_ROOT $RAILS_ROOT

# Run the app
EXPOSE 3000
CMD ["./bin/rails", "server", "-b", "0.0.0.0"]
