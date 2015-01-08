#!/bin/sh
set -x
set -o errexit
sudo -v

# Ansible
if [ ! -d ./ansible ]; then
  git clone --depth 1 -b release1.7.2 --single-branch git://github.com/ansible/ansible.git;
fi

# Ansible Deps
sudo easy_install pip
sudo pip install paramiko PyYAML jinja2
sudo pip install psycopg2

# Ansible Defaults
sudo mkdir -p /etc/ansible
cat <<-EOF | sudo tee /etc/ansible/hosts > /dev/null
localhost ansible_connection=local
EOF

# Ansible Env
source ./ansible/hacking/env-setup

# Ansible Run
ansible-playbook ansible.yml
