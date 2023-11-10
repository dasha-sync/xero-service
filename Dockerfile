FROM ruby:3.2.2
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /xero-service
COPY Gemfile /xero-service/Gemfile
COPY Gemfile.lock /xero-service/Gemfile.lock
WORKDIR /xero-service
RUN bundle
EXPOSE 3000
CMD bin/rails db:setup db:seed && bin/rails s -b 0.0.0.0
