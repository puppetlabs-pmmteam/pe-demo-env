pe_hocon_setting { "console-services.console.no-longer-reporting-cutoff":
  path    => "/etc/puppetlabs/console-services/conf.d/console.conf",
  setting => 'console.no-longer-reporting-cutoff',
  value   => 99999,
  notify  => [Exec['set immutable on console.conf'], Service['pe-console-services']],
}

exec {'set immutable on console.conf':
  command => '/bin/chattr +i /etc/puppetlabs/console-services/conf.d/console.conf',
}

service { 'pe-console-services':
  ensure   => 'running',
  enable => 'true',
}
