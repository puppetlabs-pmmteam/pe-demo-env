  application rgbank (
  $web_count = 1,
  $db_username = 'test',
  $db_password = 'test'
) {

  $webs = $web_count.map |$i| { Http["rgbank-web-${name}-${i}"] }

  rgbank::db { $name:
    user     => $db_username,
    password => $db_password,
    export   => Mysql["rgbank-${name}"],
  }

  $web_count.each |$i| {
    rgbank::web { "${name}-${i}":
      export  => Http["rgbank-web-${name}-${i}"],
      consume => Mysql["rgbank-${name}"],
    }
  }

  rgbank::load { $name:
    host    => $webs,
    consume => $webs,
    export  => Http["rgbank-web-lb-${name}"],
  }
}
