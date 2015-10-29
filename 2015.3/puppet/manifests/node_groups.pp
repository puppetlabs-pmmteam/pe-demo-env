node_group { 'PE Master':
  classes                                              => {
    'pe_repo'                                          => {},
    'pe_repo::platform::el_7_x86_64'                   => {},
    'puppet_enterprise::profile::master'               => {},
    'puppet_enterprise::profile::master::mcollective'  => {},
    'puppet_enterprise::profile::mcollective::peadmin' => {},
    'pe_r10k'                                          => {
      'remote'       => 'file:///var/lib/peadmin/site',
      'r10k_basedir' => '/etc/puppetlabs/code-staging/environments',
    }
  },
  environment => 'production',
  parent      => 'PE Infrastructure',
  rule        => [ "or", [ "=", "name", $::hostname] ],
  notify      => Exec['run puppet','deploy r10k'],
}

node_group { 'PE Infrastructure':
  classes => {
    'puppet_enterprise' => {
      'use_application_services' => true,
      'mcollective_middleware_hosts' => ["master"],
      'database_host' => "master",
      'puppetdb_host' => "master",
      'database_port' => "5432",
      'database_ssl' => true,
      'puppet_master_host' => "master",
      'certificate_authority_host' => "master",
      'console_port' => "443",
      'puppetdb_database_name' => "pe-puppetdb",
      'puppetdb_database_user' => "pe-puppetdb",
      'pcp_broker_host' => "master",
      'puppetdb_port' => "8081",
      'console_host' => "master",
      },
  },
  environment => 'production',
  parent      => 'All Nodes',
  notify      => Exec['run puppet'],
}
