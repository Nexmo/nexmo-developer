FROM ruby:2.7.2
COPY . /
RUN gem install bundler
RUN bundle install
EXPOSE 4567
ENTRYPOINT ["bundle", "exec", "/exe/nexmo-oas-renderer"]
