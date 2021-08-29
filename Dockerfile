
FROM ruby:2.7.4
ENV LANG ja_JP.utf8
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client \
    && apt-get install -y locales-all
RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install
COPY . /app

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 8000

CMD ["rails", "server", "-b", "0.0.0.0"]
