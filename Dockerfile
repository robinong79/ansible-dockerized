FROM alpine:3.6


# Default version of Ansible
ARG ANSIBLE_VERSION=2.4.2.0


# == Ansible dependencies
#
RUN \
  echo '* Installing OS Dependencies' \
  && apk add --update --no-cache \
    curl \
    openssh-client \
    tar \
    python \
    py-pip \
    build-base \
    libffi-dev \
    openssl-dev \
    python-dev \
  && echo '* Installing Ansible via PIP' \
  && pip install --upgrade \
    pip \
    docker-py \
    ansible==${ANSIBLE_VERSION} \
  && echo '* Cleaning unneeded packages' \
  && apk del \
    build-base \
    libffi-dev \
    openssl-dev \
    python-dev


# == Install Ansible
#
# Setup Ansible Layout
COPY files/hosts /etc/ansible/hosts

RUN mkdir -p /ansible/playbooks
WORKDIR /ansible/playbooks



# == Configure runtime environment
#
ENV ANSIBLE_GATHERING=smart \
    ANSIBLE_HOST_KEY_CHECKING=False \
    ANSIBLE_RETRY_FILES_ENABLED=False \
    ANSIBLE_ROLES_PATH=/ansible/playbooks/roles \
    ANSIBLE_SSH_PIPELINING=True


# == Setting Image exec behavior
#
ENTRYPOINT ["/usr/bin/ansible-playbook"]
CMD ["-h"]
