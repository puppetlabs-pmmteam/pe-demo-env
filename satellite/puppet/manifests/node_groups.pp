node_group { 'PE Master':
  classes                                              => {
    'pe_repo'                                          => {},
    'pe_repo::platform::el_7_x86_64'                   => {},
    'puppet_enterprise::profile::master'               => { 'facts_terminus' => 'satellite' },
    'puppet_enterprise::profile::master::mcollective'  => {},
    'puppet_enterprise::profile::mcollective::peadmin' => {},
    'pe_r10k'                                          => { 'remote' => 'file:///var/lib/peadmin/site' },
    'satellite_pe_tools'                               => { 'satellite_url'                => 'https://satellite',
                                                            'verify_satellite_certificate' => true,
                                                            'ssl_key'                      => '/etc/puppetlabs/puppet/ssl/satellite/master-puppet-client.key',
                                                            'ssl_cert'                     => '/etc/puppetlabs/puppet/ssl/satellite/master-puppet-client.crt',
    },
  },
  environment          => 'production',
  parent               => 'PE Infrastructure',
  rule                 => [ "or", [ "=", "name", $::hostname] ],
  require              => Exec['update classifier'],
}

## FIXME: This is bad, but has to be done or dependent node_group resources might fail if they
## declare a class that the classifier doesn't know about yet
exec { 'update classifier':
  command     => "/bin/curl -X POST -H 'Content-Type: application/json' ${curl_opts} https://localhost:4433/classifier-api/v1/update-classes",
  refreshonly => true,
}
