rbac_user { 'joe4':
  ensure       => 'present',
  name         => 'joe4',
  display_name => 'Joe Black',
  email        => 'joe@puppetlabs.com',
  password     => 'puppetlabs',
}
