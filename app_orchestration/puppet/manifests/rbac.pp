rbac_user { 'joe':
  ensure       => 'present',
  name         => 'joe',
  display_name => 'Joe Black',
  email        => 'joe@puppetlabs.com',
  password     => 'puppetlabs',
}

rbac_group { 'App Deployers':
  ensure   => 'present',
  user_ids => [ ['joe'] ],
}
