Vcsrepo {
  ensure   => present,
  provider => git,
  notify   => Exec['deploy r10k'],
}
  
vcsrepo { '/var/lib/peadmin/site':
  source   => 'https://github.com/puppetlabs-pmmteam/puppet-site.git',
}

vcsrepo { '/var/lib/peadmin/role':
  source   => 'https://github.com/puppetlabs-pmmteam/pmm-roles.git',
}

vcsrepo { '/var/lib/peadmin/profile':
  source   => 'https://github.com/puppetlabs-pmmteam/pmm-profiles.git',
}
