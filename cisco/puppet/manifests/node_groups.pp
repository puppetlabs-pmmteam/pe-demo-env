node_group { 'Networking Switches':
  ensure      => 'present',
  classes     => {
    'profile::network::base' => {}
  },
  environment => 'production',
  rule        => [ "=", [ "fact", "operatingsystem" ], "nexus" ],
  parent      => 'All Nodes',
}

node_group { 'Leaf Switches':
  ensure      => 'present',
  classes     => {
    'profile::network::igp' => {},
  },
  environment => 'production',
  rule        => [ "=", [ "fact", "role"], "leaf" ],
  parent      => 'All Nodes',
}

node_group { 'Spine Switches':
  ensure      => 'present',
  classes     => {
    'profile::network::bgp' => {},
  },
  environment => 'production',
  rule        => [ "=", [ "fact", "role"], "spine" ],
  parent      => 'All Nodes',
}

## FIXME: This is bad, but has to be done or dependent node_group resources might fail if they
## declare a class that the classifier doesn't know about yet
exec { 'update classifier':
  command     => "/bin/curl -X POST -H 'Content-Type: application/json' ${curl_opts} https://localhost:4433/classifier-api/v1/update-classes",
  refreshonly => true,
  before      => [ Node_group['Networking Switches','Leaf Switches','Spine Switches'] ],
}
