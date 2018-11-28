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
  docker build \
    --rm \
    -t ${DOCKER_IMAGE_NAME}:latest \
    -f Dockerfile.devel \
    ${DOCKER_CONTEXT}

  echo "---> Tagging"
  DOCKER_IMAGE_TAG=$(echo "$(docker run --rm ${DOCKER_IMAGE_NAME}:latest --version)" | head -n 1 | cut -d' ' -f 2)
  echo "     * DOCKER_IMAGE_TAG=${DOCKER_IMAGE_TAG}"
  docker tag ${DOCKER_IMAGE_NAME}:latest ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}


  echo "---> Listing"
  docker image ls ${DOCKER_IMAGE_NAME}:*
popd
echo "===> $0: Done"
