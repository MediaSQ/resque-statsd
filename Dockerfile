FROM ubuntu:12.04

# Install ruby 1.8.7
RUN apt-get update && apt-get install -y build-essential \
                                         libsqlite3-dev sqlite3-pcre \
                                         shared-mime-info \
                                         ruby1.8 rubygems \
                                         mercurial
# Gems
RUN gem install --no-ri --no-rdoc rake -v 0.9.2.2
RUN gem install --no-ri --no-rdoc rack -v 1.1.6
RUN gem install --no-ri --no-rdoc bundler

# Generate structure
RUN mkdir /app
COPY Gemfile /app/Gemfile
COPY *.gemspec /app
WORKDIR /app

COPY . /app

RUN ruby -v

# Bundle
RUN bundle install
