Vcsrepo {
  ensure   => latest,
  provider => git,
  notify   => Exec['deploy r10k'],
  require  => Package['git'],
}
  
package { 'git':
  ensure => installed,
}

vcsrepo { '/var/lib/peadmin/site':
  revision => production,
  source => 'https://github.com/puppetlabs-pmmteam/puppet-site.git',
}

vcsrepo { '/var/lib/peadmin/role':
  source   => 'https://github.com/puppetlabs-pmmteam/pmm-roles.git',
}

vcsrepo { '/var/lib/peadmin/profile':
  source   => 'https://github.com/puppetlabs-pmmteam/pmm-profiles.git',
}
