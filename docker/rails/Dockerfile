FROM ruby:2.6.5
ENV LANG C.UTF-8
#
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    nodejs \
 && rm -rf /var/lib/apt/lists/*

RUN gem install bundler

WORKDIR /tmp
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
RUN bundle install --jobs=4

WORKDIR /usr/src/app

CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0"]
