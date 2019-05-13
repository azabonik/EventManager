FROM ruby:2.6.0

RUN apt-get update -qq && apt-get install -y \
    nodejs \
    yarn \
    libsqlite3-dev \
    build-essential

RUN mkdir /usr/src/app
WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install --jobs 20 --retry 5

COPY . ./

ENTRYPOINT ["bundle", "exec"]

CMD ["rails", "server", "-b", "0.0.0.0"]