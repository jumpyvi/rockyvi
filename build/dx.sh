#!/bin/bash

set -ouex pipefail

dnf -y copr enable ublue-os/packages
dnf install -y --enablerepo copr:copr.fedorainfracloud.org:ublue-os:packages \
    libvirt \
    ublue-os-libvirt-workarounds \
    edk2-ovmf \
    genisoimage \
    libvirt-nss \
    virt-manager \
    virt-v2v \
    qemu-char-spice \
    qemu-device-display-virtio-gpu \
    qemu-device-display-virtio-vga \
    qemu-device-usb-redirect \
    qemu-img \
    qemu-system-x86-core \
    qemu-user-binfmt \
    qemu-user-static \
    qemu
    
dnf config-manager addrepo --from-repofile=https://download.docker.com/linux/centos/docker-ce.repo
sed -i "s/enabled=.*/enabled=0/g" /etc/yum.repos.d/docker-ce.repo
dnf -y install --enablerepo=docker-ce-stable \
    containerd.io \
    docker-buildx-plugin \
    docker-ce \
    docker-ce-cli \
    docker-compose-plugin \
    docker-model-plugin


dnf config-manager --add-repo "https://pkgs.tailscale.com/stable/centos/${MAJOR_VERSION_NUMBER}/tailscale.repo"
dnf config-manager --set-disabled "tailscale-stable"
# FIXME: tailscale EPEL10 request: https://bugzilla.redhat.com/show_bug.cgi?id=2349099
dnf -y --enablerepo "tailscale-stable" install \
	tailscale

dnf -y copr enable ublue-os/packages 
dnf -y copr disable ublue-os/packages 
dnf -y --enablerepo copr:copr.fedorainfracloud.org:ublue-os:packages install uupd