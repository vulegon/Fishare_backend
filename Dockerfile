FROM ruby:3.1.1

RUN apt-get update -qq && \
    apt-get install -y build-essential \
    libpq-dev \
    nodejs \
    vim

RUN mkdir /app

WORKDIR /app

ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock

RUN gem install bundler
RUN bundle install

COPY . .

RUN mkdir -p tmp/sockets
RUN mkdir -p tmp/pids
