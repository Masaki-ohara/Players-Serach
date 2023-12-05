#!/bin/bash
set -e

bundle install
bundle exec rails db:create
bundle exec rails db:migrate
bundle exec rails assets:precompile

exec "$@"