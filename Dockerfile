FROM jekyll/jekyll
MAINTAINER Hilmar Lapp <hlapp@drycafe.net>

RUN mkdir /tmp/site
ADD Gemfile /tmp/site
RUN \
    cd /tmp/site && \
    bundler install
