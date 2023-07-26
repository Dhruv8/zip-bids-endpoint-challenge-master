FROM ruby:3.1-alpine

RUN apk add --no-cache build-base sqlite sqlite-dev sqlite-libs tzdata

ENV BUNDLE_PATH /bundle

WORKDIR /app

RUN gem install bundler

ADD Gemfile Gemfile.lock ./
RUN bundle install

ADD . .

EXPOSE 3000

ENTRYPOINT ["docker/entrypoint.sh"]
# CMD ["bundle", "exec", "rspec", "-f", "d"]

CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0"]
