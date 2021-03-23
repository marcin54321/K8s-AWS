#!/bin/sh

# Install Ansible repository.
apt -y update && apt-get -y upgrade
apt-get install software-properties-common
apt-add-repository ppa:ansible/ansible -y

apt-get -qq install python -y

# Install Ansible.
apt-get update
apt-get install ansible -y

# Installing AWS
apt-get install awscli -y

# Installing git
apt-get install git -y
