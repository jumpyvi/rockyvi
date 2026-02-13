#!/bin/bash

set -ouex pipefail

echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf
echo "nameserver 1.1.1.1" | sudo tee -a /etc/resolv.conf

/ctx/build/desktop.sh
/ctx/build/core.sh
# /ctx/build/dx.sh


DEFAULT_USERNAME='rocky'
DEFAULT_PASSWORD='rockylinux'
DEFAULT_GROUPS='wheel'

useradd --comment "Rocky Linux" \
    --uid 1000 \
    --create-home \
    --user-group "${DEFAULT_USERNAME}" \
    --groups "${DEFAULT_GROUPS}"

echo -e "${DEFAULT_PASSWORD}\n${DEFAULT_PASSWORD}" | passwd "${DEFAULT_USERNAME}"

passwd -l root

mkdir -p /etc/flatpak/preinstall.d/
cp /ctx/build/flatpaks/default.preinstall /etc/flatpak/preinstall.d/
