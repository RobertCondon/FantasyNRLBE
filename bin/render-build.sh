#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
# No need to run asset compilation because this is an API