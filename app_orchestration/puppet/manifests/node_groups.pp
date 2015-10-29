node_group { 'Load Balancers':
  ensure      => 'present',
  classes     => { 'haproxy' => {} },
  environment => 'production',
  rule        => ['or', 
                   ['and', ['=', ['fact', 'role'], 'loadbalancer']], 
                   ['=', 'name', 'rgbankdev.delivery.puppetlabs.net']
                 ],
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
  rule        => ['or', 
                   ['and', ['=', ['fact', 'role'], 'appserver']], 
                   ['=', 'name', 'rgbankdev.delivery.puppetlabs.net']
                 ],
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
                   }
  },
  environment => 'production',
  rule        => ['or', 
                   ['and', ['=', ['fact', 'role'], 'database']], 
                   ['=', 'name', 'rgbankdev.delivery.puppetlabs.net']
                 ],
  parent      => 'All Nodes',
}
