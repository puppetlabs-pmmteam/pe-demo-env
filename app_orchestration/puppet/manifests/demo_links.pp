file { '/etc/puppetlabs/code/environments/production/manifests/site.pp':
  ensure => symlink,
  target => '/vagrant/app_orchestration/demo_site.pp',
  force  => true,
}

file { '/etc/puppetlabs/code/modules':
  ensure => directory,
  owner  => 'pe-puppet',
  group  => 'pe-puppet',
}

file { '/etc/puppetlabs/code/modules/http':
  ensure => symlink,
  target => '/vagrant/app_orchestration/demo_modules/http',
}

file { '/etc/puppetlabs/code/modules/database':
  ensure => symlink,
  target => '/vagrant/app_orchestration/demo_modules/database',
}

file { '/etc/puppetlabs/code/modules/rgbank':
  ensure => symlink,
  target => '/vagrant/app_orchestration/demo_modules/rgbank',
}
