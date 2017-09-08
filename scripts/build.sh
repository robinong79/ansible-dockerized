#!/usr/bin/env bash



# == Vars
#
PROJECT_DIR="$(git rev-parse --show-toplevel)"

DOCKER_CONTEXT="${PROJECT_DIR}"
DOCKER_IMAGE_NAME='xakra/ansible-dockerized'
DOCKER_IMAGE_TAG='latest'



# == Bash options
set -o errexit
set -o nounset
set -o pipefail



echo "===> $0: Start"
pushd ${PROJECT_DIR}

  echo "---> Building docker image"
  docker build \
    --rm \
    -t ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG} \
    ${DOCKER_CONTEXT}

popd
echo "===> $0: Done"
