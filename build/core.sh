#!/bin/bash

set -ouex pipefail

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

dnf -y copr enable ublue-os/packages
dnf install -y --enablerepo copr:copr.fedorainfracloud.org:ublue-os:packages \
    uupd