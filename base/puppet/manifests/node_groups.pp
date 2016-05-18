
node_group { 'PE Infrastructure':
  classes                            => {
    'puppet_enterprise'              => {
      'use_application_services'     => true,
      'mcollective_middleware_hosts' => ["master"],
      'database_host'                => "master",
      'puppetdb_host'                => 'master',
      'database_port'                => '5432',
      'database_ssl'                 => true,
      'puppet_master_host'           => 'master',
      'certificate_authority_host'   => 'master',
      'console_port'                 => '443',
      'puppetdb_database_name'       => 'pe-puppetdb',
      'puppetdb_database_user'       => 'pe-puppetdb',
      'pcp_broker_host'              => 'master',
      'puppetdb_port'                => '8081',
      'console_host'                 => 'master'
    },
    environment => 'production',
    require     => Exec['update classifier'],
  }
}

node_group { 'PE Master':
  classes                                              => {
    'pe_repo'                                          => {},
    'pe_repo::platform::el_7_x86_64'                   => {},
    'pe_repo::platform::el_6_x86_64'                   => {},
    'pe_repo::platform::debian_7_amd64'                => {},
    'pe_repo::platform::debian_8_amd64'                => {},
    'pe_repo::platform::ubuntu_1510_amd64'             => {},
    'pe_repo::platform::ubuntu_1504_amd64'             => {},
    'pe_repo::platform::windows_x86_64'                => {},
    'puppet_enterprise::profile::master'               => {
      'file_sync_enabled' => true,
      'code_manager_auto_config' => true
    },
    'puppet_enterprise::profile::master::mcollective'  => {},
    'puppet_enterprise::profile::mcollective::peadmin' => {},
  },
  environment          => 'production',
  parent               => 'PE Infrastructure',
  rule                 => [ "or", [ "=", "name", $::hostname] ],
  require              => Exec['update classifier'],
}
