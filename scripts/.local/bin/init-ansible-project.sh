#!/bin/bash
# Simple script to quickly start an ansible project
# Copied from https://github.com/ansible-buch/init-ansible-project
# and then adapted to my taste. Kudos therefore to Axel Miesen!

PROGNAME=$(basename $0)
PROJECTPATH=$1

if test -z "$PROJECTPATH"; then
    echo "Usage: $PROGNAME <PROJECTPATH>" 1>&2
    exit 1
fi

if test -e "$PROJECTPATH"; then
    echo "$PROGNAME: directory '$PROJECTPATH' already exists" 1>&2
    exit 2
fi


mkdir -vp $PROJECTPATH
pushd $PROJECTPATH >/dev/null

for d in playbooks {group,host}_vars roles; do
    mkdir -v $d
done


function write_out() {
    sed -rn -e '/^={20}[[:space:]]*'"$1"'/,/={20}/p' $0 |
    sed -r -e 1d -e '$d' \
	>$1

    echo "$PROGNAME: created '$1'"
}


for f in ansible.cfg .envrc inventory; do
    write_out $f
done

exit 0


# shellcheck disable=all
{
==================== ansible.cfg ====================
[defaults]
inventory = ./inventory
collections_paths = ./collections
roles_path = ./roles

#stdout_callback = yaml

gathering = smart
fact_caching = jsonfile
fact_caching_connection = ~/.ansible/fact_cache
fact_caching_timeout = 86400

retry_files_enabled = yes
retry_files_save_path = ~/.ansible/retry-files

force_handlers = true
nocows = true
ansible_managed = "Managed by ansible, don't make changes here!"

[ssh_connection]
pipelining = true
==================== .envrc ====================
export ANSIBLE_CONFIG=$(expand_path ansible.cfg)
export ANSIBLE_FORCE_COLOR: '1'
export PY_COLORS=1
==================== inventory ====================
[all:vars]
# ansible_user=ansible
# ansible_user=vagrant
# ansible_ssh_private_key_file=~/.vagrant.d/insecure_private_key
ansible_python_interpreter=/usr/bin/python3
ansible_ssh_common_args='-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
====================
}
