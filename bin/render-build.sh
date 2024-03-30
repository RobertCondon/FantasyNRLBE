#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
rails db:migrate
# No need to run asset compilation because this is an API