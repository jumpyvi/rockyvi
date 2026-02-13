#!/bin/bash

set -ouex pipefail

dnf group install -y "Workstation"

dnf install gnome-initial-setup -y

dnf remove gnome-software PackageKit gnome-calculator gnome-clocks gnome-camera firefox loupe papers snapshot -y