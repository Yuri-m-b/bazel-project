#!/usr/bin/env bash

COMMIT_SHA=$(git rev-parse HEAD)
REPO=$(git config --get remote.origin.url)
BRANCH=$(git rev-parse --abbrev-ref HEAD)
ROLE="demo-ci" # some indication of the role of the build machine

echo "STABLE_REPO ${REPO}"
echo "STABLE_BRANCH ${BRANCH}"
echo "COMMIT_SHA ${COMMIT_SHA}"
echo "ROLE ${ROLE}"
