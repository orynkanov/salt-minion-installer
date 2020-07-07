#!/bin/bash

# SCRIPTDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

#start check
if [[ ! -f /etc/centos-release ]]; then
    echo OS not CentOS. This script only for CentOS!
    exit 1
fi
#finish check

OSVER=$(grep -o '[0-9]' /etc/centos-release | head -n1)
if [[ $OSVER -eq 7 ]]; then
    yum install -y https://repo.saltstack.com/py3/redhat/salt-py3-repo-latest.el7.noarch.rpm
    yum clean all
    yum install -y salt-minion
elif [[ $OSVER -eq 8 ]]; then
    dnf install -y https://repo.saltstack.com/py3/redhat/salt-py3-repo-latest.el8.noarch.rpm
    dnf clean all
    dnf install -y salt-minion
fi

hostname -s > /etc/salt/minion_id

systemctl enable salt-minion --now
