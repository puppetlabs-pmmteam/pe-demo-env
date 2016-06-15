node_group { 'Jenkins':
  classes     => {
    'role::jenkins' => {}
  },
  environment => 'production',
  parent      => 'All Nodes',
  rule        => [ "or", [ "=", "name", "jenkins"] ],
  require     => Exec['update classifier'],
}

## FIXME: This is bad, but has to be done or dependent node_group resources might fail if they
## declare a class that the classifier doesn't know about yet
exec { 'update classifier':
  command     => "/bin/curl -X POST -H 'Content-Type: application/json' ${curl_opts} https://localhost:4433/classifier-api/v1/update-classes",
  refreshonly => true,
}
