FROM ruby:3.0.0
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /ov_application
WORKDIR /ov_application
COPY Gemfile /ov_application/Gemfile
COPY Gemfile.lock /ov_application/Gemfile.lock
RUN bundle install
COPY . /ov_application

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]