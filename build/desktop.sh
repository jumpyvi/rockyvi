#!/bin/bash

set -ouex pipefail

dnf group install -y "Workstation"

dnf install gnome-initial-setup gnome-tweaks firewall-config -y

dnf remove gnome-software PackageKit gnome-calculator gnome-system-monitor gnome-clocks gnome-camera firefox loupe papers snapshot -y