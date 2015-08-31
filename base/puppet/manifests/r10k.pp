$configprint = "/opt/puppetlabs/puppet/bin/puppet agent --configprint"
$cacert      = "`${configprint} localcacert`"
$cert        = "`${configprint} hostcert`"
$key         = "`${configprint} hostprivkey`"
$curl_opts   = "--cacert ${cacert} --cert ${cert} --key ${key} --insecure"

class { 'pe_r10k':
  remote  => 'file:///var/lib/peadmin/site',
  notify  => Exec['deploy r10k'],
  require => Vcsrepo['/var/lib/peadmin/site'],
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
