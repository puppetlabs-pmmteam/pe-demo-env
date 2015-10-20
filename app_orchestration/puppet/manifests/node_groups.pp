node_group { 'Load Balancers':
  ensure               => 'present',
  classes              => {
    'profile::loadbalancer' => {}
  },
  environment          => 'production',
  rule                 => [ "=", [ "fact", "role" ], "loadbalancer" ],
  parent               => 'All Nodes',
}

node_group { 'App Servers':
  ensure               => 'present',
  classes              => {
    'profile::appserver' => {}
  },
  environment          => 'production',
  rule                 => [ "=", [ "fact", "role" ], "appserver" ],
  parent               => 'All Nodes',
}

node_group { 'Database Servers':
  ensure               => 'present',
  classes              => {
    'profile::database' => {}
  },
  environment          => 'production',
  rule                 => [ "=", [ "fact", "role" ], "database" ],
  parent               => 'All Nodes',
}
