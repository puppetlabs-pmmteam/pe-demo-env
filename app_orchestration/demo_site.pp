site {
  # rgbank { 'staging':
  #   web_count => 2,
  #   nodes     => {
  #     Node['appserver01.vm']  => [ Rgbank::Web['staging-0'] ],
  #     Node['appserver02.vm']  => [ Rgbank::Web['staging-1'] ],
  #     Node['loadbalancer.vm'] => [ Rgbank::Load['staging'] ],
  #     Node['database.vm']     => [ Rgbank::Db['staging'] ],
  #   },
  # }
  #
  # rgbank { 'dev':
  #   nodes               => {
  #     Node['rgbankdev.vm'] => [ Rgbank::Web['dev-0'],
  #                            Rgbank::Load['dev'],
  #                            Rgbank::Db['dev'] ],
  #   },
  # }
}
