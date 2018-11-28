#!/usr/bin/env bash



# == Vars
#
PROJECT_DIR="$(git rev-parse --show-toplevel)"

DOCKER_CONTEXT="${PROJECT_DIR}"
DOCKER_IMAGE_NAME='xakra/ansible'



# == Bash options
set -o errexit
set -o nounset
set -o pipefail



echo "===> $0: Start"
pushd ${PROJECT_DIR}

  echo "---> Building docker image"
  DOCKER_IMAGE_TAG=$(grep 'VERSION=' Dockerfile | cut -d'=' -f2)

  docker build \
    --rm \
    -t ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG} \
    -f Dockerfile
    ${DOCKER_CONTEXT}

popd
echo "===> $0: Done"
