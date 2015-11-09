node_group { 'Load Balancers':
  ensure      => 'present',
  classes     => { 'haproxy' => {} },
  environment => 'production',
  rule        => ['and', ['~', ['fact', 'role'], 'loadbalancer']],
  parent      => 'All Nodes',
}

node_group { 'App Servers':
  ensure      => 'present',
  classes     => { 'mysql::bindings::php' => {},
                   'mysql::client'        => {},
                   'apache'               => { 'default_vhost' => false },
                   'apache::mod::php'     => {},
                   'git'                  => {},
  },
  environment => 'production',
  rule        => ['and', ['~', ['fact', 'role'], 'appserver']],
  parent      => 'All Nodes',
}

node_group { 'Database Servers':
  ensure      => 'present',
  classes     => { 'mysql::server' => {
                     'override_options' => {
                       'mysqld' => {
                         'bind-address' => '0.0.0.0'
                       }
                     }
                 },
                 'git' => {},
  },
  environment => 'production',
  rule        => ['and', ['~', ['fact', 'role'], 'database']],
  parent      => 'All Nodes',
}
