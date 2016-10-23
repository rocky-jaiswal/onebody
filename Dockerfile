FROM ruby:2.3.1

# Install dependencies:
RUN apt-get update && apt-get install -qq -y build-essential nodejs mysql-client --fix-missing --no-install-recommends

RUN gem install bundler -v 1.13.2
RUN gem install rake

RUN mkdir -p /app

# This sets the context of where commands will be ran in and is documented
# on Docker's website extensively.
WORKDIR /app

# Copy in the application code from the current directory
# over to the working directory and run bundle
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle install --binstubs

ADD . /app

# The default command that gets ran will be to start the Unicorn server.
CMD bin/rails s -b '0.0.0.0'
