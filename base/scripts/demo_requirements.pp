class { 'virtualbox':
  version => '5.0.4',
  build   => '102546',
}

class { 'vagrant': }

Vagrant::Plugin { user => $::username }

vagrant::plugin { 'oscar': }
vagrant::plugin { 'vagrant-vbox-snapshot': }
