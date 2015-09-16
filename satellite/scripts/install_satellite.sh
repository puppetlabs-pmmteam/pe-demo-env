#!/bin/sh

if ! [ -d /opt/satellite ]; then
  export dnsdomainname=`cat /etc/resolv.conf | grep domain | awk '{ print $2 }'`
  export hostname=`hostname`
  sed -i -- 's/^127.0.1.1.*//' /etc/hosts
  sed -i -- "s/$hostname/$hostname.$dnsdomainname $hostname/" /etc/hosts

  mkdir -p /mnt/iso
  curl http://osmirror.delivery.puppetlabs.net/iso/satellite-6.0.4-rhel-7-x86_64-dvd.iso > /tmp/satellite-6.0.4-rhel-7-x86_64-dvd.iso
  mount /tmp/satellite-6.0.4-rhel-7-x86_64-dvd.iso -o loop /mnt/iso
  
  cd /mnt/iso
  /mnt/iso/install_packages

  katello-installer --capsule-dns false --capsule-tftp true --foreman-admin-password "puppetlabs"

  puppet agent -t
fi
