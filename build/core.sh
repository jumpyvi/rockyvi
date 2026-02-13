#!/bin/bash

set -ouex pipefail

cp -avf "/tmp/ctx/files"/. /

systemctl enable brew-setup.service

dnf update -y

dnf install -y \
    vim \
    tree \
    flatpak \
    firewalld \
    hplip \
    ntfs-3g \
    btrfs-progs \
    wl-clipboard \
    xhost \
    wireguard-tools

dnf -y --setopt=install_weak_deps=False install gcc