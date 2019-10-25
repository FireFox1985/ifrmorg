FROM ruby:2.6-slim

RUN apt-get update -qq && \
    apt-get install -y build-essential cmake git tzdata libpq-dev  ruby-dev curl

# Install nodejs
RUN curl -sL https://deb.nodesource.com/setup_11.x | bash - && \
  apt-get install -y nodejs

# yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -\
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update \
    && apt-get install -y yarn

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir /app
WORKDIR /app

RUN gem install bundler -v 2.0.1

CMD ["bash"]
