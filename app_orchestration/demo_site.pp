site {
  #rgbank { 'staging':
  #  web_count => 2,
  #  nodes     => {
  #    Node['appserver01']  => [ Rgbank::Web['staging-0'] ],
  #    Node['appserver02']  => [ Rgbank::Web['staging-1'] ],
  #    Node['loadbalancer'] => [ Rgbank::Load['staging'] ],
  #    Node['database'] => [ Rgbank::Db['staging'] ],
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
