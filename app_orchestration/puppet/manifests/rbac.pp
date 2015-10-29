rbac_user { 'joe':
  ensure       => 'present',
  name         => 'joe',
  display_name => 'Joe Black',
  email        => 'joe@puppetlabs.com',
  password     => 'puppetlabs',
}
