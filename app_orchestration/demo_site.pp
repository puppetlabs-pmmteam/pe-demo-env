site {
  #rgbank { 'staging':
  #  web_count => 2,
  #  nodes     => {
  #    Node['appserver01.delivery.puppetlabs.net']  => [ Rgbank::Web['staging-0'] ],
  #    Node['appserver02.delivery.puppetlabs.net']  => [ Rgbank::Web['staging-1'] ],
  #    Node['loadbalancer.delivery.puppetlabs.net'] => [ Rgbank::Load['staging'] ],
  #    Node['database.delivery.puppetlabs.net']     => [ Rgbank::Db['staging'] ],
  #  },
  #}

  rgbank { 'dev':
    nodes               => {
      Node['rgbankdev.delivery.puppetlabs.net'] => [ Rgbank::Web['dev-0'],
                             Rgbank::Load['dev'],
                             Rgbank::Db['dev'] ],
    },
  }
}
