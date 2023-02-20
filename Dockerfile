FROM amd64/ruby:2.7.3

RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       nodejs

RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get install -y nodejs    

RUN mkdir /runapp
WORKDIR /runapp

ADD Gemfile /runapp/Gemfile
ADD Gemfile.lock /runapp/Gemfile.lock

RUN bundle install

ADD . /runapp

RUN mkdir -p tmp/sockets
