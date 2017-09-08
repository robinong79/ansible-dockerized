# Ansible Playbook Docker Image

<!-- MarkdownTOC -->

- [1- Build](#1--build)
- [2 - Run](#2---run)
  - [Basics](#basics)
  - [SSH Keys](#ssh-keys)
  - [Ansible Vault](#ansible-vault)
  - [Testing Playbooks - Ansible Target Container](#testing-playbooks---ansible-target-container)
  - [Utils](#utils)

<!-- /MarkdownTOC -->



## 1- Build

[![Docker Automated build](https://img.shields.io/docker/automated/xakra/ansible-dockerizes.svg)]()
[![Docker Build Status](https://img.shields.io/docker/build/xakra/ansible-dockerized.svg)]()
[![Docker Pulls](https://img.shields.io/docker/pulls/xakra/ansible-dockerized.svg)]()


* Based on `Alpine Linux`
* Use the new `ARG` variable from Docker >= 1.10
* Install Ansible from PyPi


```
$ docker build . --build-args ansible_version=2.2.1.0
```


https://docs.docker.com/engine/reference/builder/#arg



## 2 - Run

Executes `ansible-playbook` command against an externally mounted set of Ansible playbooks.

```
docker run --rm -it \
  -v PATH_TO_LOCAL_PLAYBOOKS_DIR:/ansible/playbooks \
  xakra/ansible-dockerized \
  PLAYBOOK_FILE \
  <ANY_OPTION>
```



### Basics

For example, assuming your project's structure follows best practices, the command to run ansible-playbook from the top-level directory would look like:

```
docker run --rm -it \
  -v $(pwd):/ansible/playbooks \
  xakra/ansible-dockerized \
  site.yml
```

> Note:
> --
> Ansible playbook variables can simply be added after the playbook name.



### SSH Keys

If Ansible is interacting with external machines, you'll need to mount an SSH key pair for the duration of the play:

```
docker run --rm -it \
    -v ~/.ssh/id_rsa:/root/.ssh/id_rsa \
    -v ~/.ssh/id_rsa.pub:/root/.ssh/id_rsa.pub \
    -v $(pwd):/ansible/playbooks \
    xakra/ansible-dockerized site.yml
```


### Ansible Vault

If you've encrypted any data using Ansible Vault, you can decrypt during a play by either passing --ask-vault-pass after the playbook name, or pointing to a password file. For the latter, you can mount an external file:

```
docker run --rm -it \
    -v $(pwd):/ansible/playbooks \
    -v ~/.vault_pass.txt:/root/.vault_pass.txt \
    xakra/ansible-dockerized site.yml \
    --vault-password-file /root/.vault_pass.txt
```

Note: the Ansible Vault executable is embedded in this image. To use it, specify a different entrypoint:

```
docker run --rm -it \
  -v $(pwd):/ansible/playbooks \
  --entrypoint /usr/bin/ansible-vault \
  xakra/ansible-dockerized encrypt FILENAME
```


### Testing Playbooks - Ansible Target Container

The Ansible Target Docker image is an SSH container optimized for testing Ansible playbooks.

First, define your inventory file.

```
[test]
ansible_target
```

Be sure your testing playbooks include the correct host and remote user:

```
- hosts: test
  remote_user: ubuntu

  tasks:
  ... tasks go here ...
```

When testing the playbook, you'll need to link the two containers:

```
docker run --rm -it \
    --link ansible_target \
    -v ~/.ssh/id_rsa:/root/.ssh/id_rsa \
    -v ~/.ssh/id_rsa.pub:/root/.ssh/id_rsa.pub \
    -v $(pwd):/ansible/playbooks \
    xakra/ansible-dockerized tests.yml -i inventory
```

Note: the SSH key used above should match the one used to run Ansible Target.


### Utils

Have a look at the `bin/ansible` file
