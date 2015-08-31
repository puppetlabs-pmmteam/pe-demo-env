#!/bin/sh

if ! [ -d /opt/satellite ]; then
  mkdir -p /mnt/iso
  curl http://osmirror.delivery.puppetlabs.net/iso/satellite-6.0.4-rhel-7-x86_64-dvd.iso > /tmp/satellite-6.0.4-rhel-7-x86_64-dvd.iso
  mount /tmp/satellite-6.0.4-rhel-7-x86_64-dvd.iso -o loop /mnt/iso
  
  cd /mnt/iso
  /mnt/iso/install_packages

  katello-installer --capsule-dns false --capsule-tftp true --foreman-admin-password "puppetlabs"

  puppet agent -t
fi
