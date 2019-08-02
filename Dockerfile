FROM ruby:2.6.3
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /docker-api-only
WORKDIR /docker-api-only
COPY Gemfile /docker-api-only/Gemfile
COPY Gemfile.lock /docker-api-only/Gemfile.lock
RUN bundle install
COPY . /docker-api-only

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
