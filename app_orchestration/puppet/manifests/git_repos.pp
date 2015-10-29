package { 'git':
  ensure => present,
}

vcsrepo { '/var/lib/rgbank_app':
  ensure   => present,
  source   => 'https://github.com/puppetlabs-pmmteam/rgbank.git',
  provider => git,
}
