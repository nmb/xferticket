FROM ruby:2.5

RUN bundle config --global frozen 1

WORKDIR /usr/src/app

RUN adduser --system --group ruby
USER ruby
RUN mkdir /tmp/xferticket/

EXPOSE 5000

COPY --chown=ruby Gemfile Gemfile.lock ./
RUN bundle update --bundler && \
    bundle install

CMD bundle exec foreman start
