define rgbank::web (
  $db_name,
  $db_host,
  $db_user,
  $db_password,
  $install_dir = undef,
) {

  if $install_dir {
    $install_dir_real = $install_dir
  } else {
    $install_dir_real = "/opt/rgbank-${name}"
  }

  #vcsrepo { '/opt/rgbank':
  #  ensure   => present,
  #  source   => 'file:///var/lib/rgbank',
  #  provider => git,
  #}

  wordpress::instance::app { "rgbank_${name}":
    install_dir          => $install_dir_real,
    install_url          => 'http://wordpress.org',
    version              => '3.8',
    db_name              => $db_name,
    db_host              => $db_host,
    db_user              => $db_user,
    db_password          => $db_password,
    wp_owner             => 'root',
    wp_group             => '0',
    wp_lang              => '',
    wp_config_content    => undef,
    wp_plugin_dir        => 'DEFAULT',
    wp_additional_config => 'DEFAULT',
    wp_table_prefix      => 'wp_',
    wp_proxy_host        => '',
    wp_proxy_port        => '',
    wp_multisite         => false,
    wp_site_domain       => '',
    wp_debug             => false,
    wp_debug_log         => false,
    wp_debug_display     => false,
  }

  apache::vhost { $::fqdn:
    docroot => $install_dir_real,
    port    => 80,
  }
}

Rgbank::Web produces Http {
  name => $name,
  ip   => $::ipaddress,
  port => 80,
  host => $::fqdn,
}

Rgbank::Web consumes Mysql {
  db_name     => $name,
  db_host     => $host,
  db_user     => $user,
  db_password => $password,
}
