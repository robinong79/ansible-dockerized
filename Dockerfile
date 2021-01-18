FROM alpine:3.6


# Default version of Ansible
ARG ANSIBLE_VERSION=2.7.9


# == Setup container
#
ENTRYPOINT ["/usr/bin/ansible-playbook"]
CMD ["-h"]


# == Configure runtime environment
#
ENV ANSIBLE_GATHERING=smart \
    ANSIBLE_HOST_KEY_CHECKING=False \
    ANSIBLE_RETRY_FILES_ENABLED=False \
    ANSIBLE_ROLES_PATH=/ansible/playbooks/roles \
    ANSIBLE_SSH_PIPELINING=True

# Setup Ansible Layout
COPY files/hosts /etc/ansible/hosts

RUN mkdir -p /ansible/playbooks
WORKDIR /ansible/playbooks


# == Install Ansible dependencies
#
RUN \
  echo '* Installing OS Dependencies' \
  && apk add --update --no-cache \
    build-base \
    curl openssh-client tar \
    python python-dev cryptography py-pip \
    libffi-dev openssl-dev \
  && echo '* Installing Ansible via PIP' \
  && pip install --upgrade \
    pip \
    docker \
    ansible==${ANSIBLE_VERSION} \
  && echo '* Cleaning unneeded packages' \
  && apk del \
    build-base \
    libffi-dev openssl-dev \
    python-dev
