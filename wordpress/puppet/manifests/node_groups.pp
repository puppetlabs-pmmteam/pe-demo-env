node_group { 'Wordpress':
  ensure               => 'present',
  classes              => {
    'profile::wordpress' => {}
  },
  environment          => 'production',
  rule                 => [ "=", [ "fact", "role" ], "wordpress" ],
  parent               => 'All Nodes',
}
