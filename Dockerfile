FROM ruby:2.6.3
ENV RAILS_ROOT /var/www/docker-api-only
ENV RAILS_SERVE_STATIC_FILES enabled
ENV RAILS_ENV production
ENV RACK_ENV production

# Install Nodejs
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends nodejs

# Install Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install yarn
RUN rm -rf /var/lib/apt/lists

# Set working directory, where the commands will be ran:
RUN mkdir -p $RAILS_ROOT
WORKDIR $RAILS_ROOT

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install --jobs 20 --retry 5 --without development test
COPY . .

# RUN bundle exec rake assets:precompile
# We don't need assets for API app

# Start the main process.
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb", "-p", "80"]
