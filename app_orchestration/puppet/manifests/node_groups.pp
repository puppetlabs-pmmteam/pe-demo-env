node_group { 'Load Balancers':
  ensure               => 'present',
  classes              => { },
  environment          => 'production',
  rule                 => [ "=", [ "fact", "role" ], "loadbalancer" ],
  parent               => 'All Nodes',
}

node_group { 'App Servers':
  ensure               => 'present',
  classes              => { },
  environment          => 'production',
  rule                 => [ "=", [ "fact", "role" ], "appserver" ],
  parent               => 'All Nodes',
}

node_group { 'Database Servers':
  ensure               => 'present',
  classes              => { },
  environment          => 'production',
  rule                 => [ "=", [ "fact", "role" ], "database" ],
  parent               => 'All Nodes',
}
