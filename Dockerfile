FROM noonat/rbenv-nodenv
MAINTAINER Nathan Ostgard <noonat@phuce.com>

# Install Ruby 2.2.0
RUN rbenv install 2.2.0 && \
    CONFIGURE_OPTS="--disable-install-doc" rbenv global 2.2.0 && \
    gem install bundler && \
    rbenv rehash

# Copy the Gemfiles and install gems. We copy only these files first so that
# Docker can still use the cached bundle install step, even when other source
# files are changing.
COPY Gemfile /opt/docker-sinatra-example/Gemfile
COPY Gemfile.lock /opt/docker-sinatra-example/Gemfile.lock
WORKDIR /opt/docker-sinatra-example
RUN bundle install

# Now add the rest of the files
COPY . /opt/docker-sinatra-example

# Run the server
EXPOSE 80
ENV RACK_ENV=production
CMD ["bundle", "exec", "rake", "server:run"]
