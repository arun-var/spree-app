FROM ruby:2.5.1
RUN apt-get update -qq && apt-get -y install apt-transport-https apt-utils build-essential libpq-dev && \
    curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
    apt-get install -y build-essential libpq-dev nodejs && \
    APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1 curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get -y install yarn


COPY Gemfile  Gemfile.lock /tmp/app/
RUN cd /tmp/app && \
bundle config git.allow_insecure true && \
gem install bundler && \
bundle install -j 10 && yarn install --check-files && rm -rf /tmp/*

COPY . /tmp/app/

