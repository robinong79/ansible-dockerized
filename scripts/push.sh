#!/usr/bin/env bash



# == Vars
#
PROJECT_DIR="$(git rev-parse --show-toplevel)"

DOCKER_CONTEXT="${PROJECT_DIR}"
DOCKER_IMAGE_NAME='xakra/ansible-dockerized'
DOCKER_IMAGE_TAG=$(git describe --tag)



# == Bash options
#
set -o errexit
set -o nounset
set -o pipefail


echo "===> $0: Start"
pushd ${PROJECT_DIR}

  echo "---> Tagging image compared to REPO: ${DOCKER_IMAGE_TAG}"
  docker tag ${DOCKER_IMAGE_NAME}:latest \
             ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}

  echo "---> Listing local versions of ${DOCKER_IMAGE_NAME}"
  docker images | grep ${DOCKER_IMAGE_NAME}

  echo "---> Pushing image to Docker Hub"
  docker push ${DOCKER_IMAGE_NAME}:latest
  docker push ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}
popd
echo "===> $0: Done"
