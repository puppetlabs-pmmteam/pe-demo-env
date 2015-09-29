$leinengin_command = "/usr/local/bin/lein run benchmark \
-c /etc/puppetlabs/puppetdb/conf.d/config.ini \
-n 512 \
-N 2 \
-r 20 \
-F /vagrant/reporting/fake_data/facts/ -C /vagrant/reporting/fake_data/catalogs \
-R /vagrant/reporting/fake_data/reports; touch /tmp/loaded"

exec { 'populate fake data':
  command => $leinengin_command,
  creates => '/tmp/loaded',
  cwd     => '/opt/puppetdb',
  require => [ 
    File['/usr/local/bin/lein'], 
    Vcsrepo['/opt/puppetdb']
  ],
}
