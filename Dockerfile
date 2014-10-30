FROM rails
MAINTAINER Zach Latta <zach@hackedu.us>

ADD https://codeload.github.com/cantino/huginn/tar.gz/master \
  /tmp/huginn.tar.gz
RUN cd /tmp && \
      tar xzf huginn.tar.gz && \
      mv huginn-master /usr/src/app && \
      rm huginn.tar.gz

WORKDIR /usr/src/app

# We set ON_HEROKU to true to make sure gems installed for Heroku, like
# Unicorn, are installed. See
# https://github.com/cantino/huginn/blob/master/Gemfile#L120
RUN ON_HEROKU=true bundle install --without development test

# Since we don't have Nginx or Apache sitting in front of Rails in this image,
# we want Rails to serve the static assets.
RUN sed -i \
  's/config.serve_static_assets = false/config.serve_static_assets = true/' \
  config/environments/production.rb
COPY ./unicorn.rb /usr/src/app/config/unicorn.rb

# We set the APP_SECRET_TOKEN to 1 so Devise won't fail. Don't actually set it
# to this when a container from this image is launched.
RUN RAILS_ENV=production APP_SECRET_TOKEN=1 bundle exec rake assets:precompile

EXPOSE 3000
