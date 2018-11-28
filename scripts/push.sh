#!/usr/bin/env bash



# == Vars
#
PROJECT_DIR="$(git rev-parse --show-toplevel)"

DOCKER_CONTEXT="${PROJECT_DIR}"
DOCKER_IMAGE_NAME='xakra/ansible'


# == Bash options
#
set -o errexit
set -o nounset
set -o pipefail


echo "===> $0: Start"
pushd ${PROJECT_DIR}

  echo "---> Listing local versions of ${DOCKER_IMAGE_NAME}"
  docker image ls ${DOCKER_IMAGE_NAME}:*

  echo "---> Pushing image to Docker Hub"
  docker push ${DOCKER_IMAGE_NAME}

popd
echo "===> $0: Done"
