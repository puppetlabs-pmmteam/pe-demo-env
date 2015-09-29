class { 'java':
  distribution => 'jre',
}

exec { "install leiningen":
  command     => "/bin/curl https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein > /usr/local/bin/lein",
  creates     => "/usr/local/bin/lein",
}

file { '/usr/local/bin/lein':
  ensure  => file,
  mode    => '0755',
  owner   => 0,
  group   => 0,
  require => Exec['install leiningen'],
}

vcsrepo { '/opt/puppetdb':
  ensure   => present,
  source   => 'https://github.com/puppetlabs/puppetdb.git',
  provider => git,
  require  => Package['git'],
}
