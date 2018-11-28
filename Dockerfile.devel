FROM alpine:3.6


# == Setup container
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


# == Install Ansible
#
RUN \
  echo '* Installing OS Dependencies' \
  && apk add --update --no-cache \
    build-base \
    curl openssh-client tar \
    python python-dev py-pip \
    libffi-dev openssl-dev \
    git \
  && echo '* Installing Ansible via PIP' \
  && pip install --upgrade \
    pip \
    docker \
    git+https://github.com/ansible/ansible.git@devel \
  && echo '* Cleaning unneeded packages' \
  && apk del \
    build-base \
    libffi-dev openssl-dev \
    python-dev \
    git