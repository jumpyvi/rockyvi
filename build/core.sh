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

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo