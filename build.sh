#!/bin/bash

bundle install

if [ "$1" == "ci_build" ]; then
  # Build + tests
  bundle exec fastlane ci_build

elif [ "$1" == "beta" ]; then
  # Build + upload TestFlight
  bundle exec fastlane beta

else
  echo "Usage: $0 {ci_build|beta}"
  exit 1
fi
