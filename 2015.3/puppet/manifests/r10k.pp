$configprint = "/opt/puppetlabs/puppet/bin/puppet agent --configprint"
$cacert      = "`${configprint} localcacert`"
$cert        = "`${configprint} hostcert`"
$key         = "`${configprint} hostprivkey`"
$curl_opts   = "--cacert ${cacert} --cert ${cert} --key ${key} --insecure"

exec { 'run puppet':
  command     => '/opt/puppetlabs/bin/puppet agent -t',
  refreshonly => true,
  returns     => [0,2],
  notify      => Exec['deploy r10k'],
}

exec { 'deploy r10k':
  command     => '/opt/puppetlabs/puppet/bin/r10k deploy environment -p',
  refreshonly => true,
  notify      => Exec['update classifier'],
}

## FIXME: This is bad, but has to be done or dependent node_group resources might fail if they
## declare a class that the classifier doesn't know about yet
exec { 'update classifier':
  command     => "/bin/curl -X POST -H 'Content-Type: application/json' ${curl_opts} https://localhost:4433/classifier-api/v1/update-classes",
  refreshonly => true,
}

file { '/etc/puppetlabs/code/environments':
  ensure => symlink,
  force  => true,
  target => '/etc/puppetlabs/code-staging/environments',
  notify => Exec['update classifier'],
}
