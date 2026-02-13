set -xeuo pipefail

sed -i 's|uupd|& --disable-module-distrobox|' /usr/lib/systemd/system/uupd.service

# Enable sleep then hibernation by DEFAULT!
sed -i 's/#HandleLidSwitch=.*/HandleLidSwitch=suspend-then-hibernate/g' /usr/lib/systemd/logind.conf
sed -i 's/#HandleLidSwitchDocked=.*/HandleLidSwitchDocked=suspend-then-hibernate/g' /usr/lib/systemd/logind.conf
sed -i 's/#HandleLidSwitchExternalPower=.*/HandleLidSwitchExternalPower=suspend-then-hibernate/g' /usr/lib/systemd/logind.conf
sed -i 's/#SleepOperation=.*/SleepOperation=suspend-then-hibernate/g' /usr/lib/systemd/logind.conf
systemctl enable brew-setup.service
systemctl enable gdm.service
systemctl enable firewalld.service
systemctl enable fwupd.service
systemctl --global enable podman-auto-update.timer
systemctl disable rpm-ostree.service
systemctl enable dconf-update.service
systemctl --global enable bazaar.service
systemctl disable mcelog.service
# systemctl enable tailscaled.service
systemctl enable uupd.timer
systemctl enable ublue-system-setup.service
systemctl --global enable ublue-user-setup.service
systemctl mask bootc-fetch-apply-updates.timer bootc-fetch-apply-updates.service
systemctl disable sshd.service

# Disable lastlog display on previous failed login in GDM (This makes logins slow)
authselect enable-feature with-silent-lastlog

# Enable polkit rules for fingerprint sensors via fprintd
authselect enable-feature with-fingerprint

sed -i -e "s@PrivateTmp=.*@PrivateTmp=no@g" /usr/lib/systemd/system/systemd-resolved.service
# FIXME: this does not yet work, the resolution service fails for somer reason
# enable systemd-resolved for proper name resolution
systemctl enable systemd-resolved.service


curl -fsSLo /usr/lib/firewalld/zones/FedoraWorkstation.xml "https://src.fedoraproject.org/rpms/firewalld/raw/rawhide/f/FedoraWorkstation.xml"
grep -F -e '<port protocol="udp" port="1025-65535"/>' /usr/lib/firewalld/zones/FedoraWorkstation.xml

# https://src.fedoraproject.org/rpms/firewalld/blob/rawhide/f/firewalld.spec#_178
sed -i 's|^DefaultZone=.*|DefaultZone=FedoraWorkstation|g' /etc/firewalld/firewalld.conf
sed -i 's|^IPv6_rpfilter=.*|IPv6_rpfilter=loose|g' /etc/firewalld/firewalld.conf
grep -F -e "DefaultZone=FedoraWorkstation" /etc/firewalld/firewalld.conf
grep -F -e "IPv6_rpfilter=loose" /etc/firewalld/firewalld.conf