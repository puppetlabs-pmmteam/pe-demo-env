define rgbank::db (
  $user,
  $password,
) {
  $db_name = "rgbank-${name}"

  mysql::db { $db_name:
    user     => $user,
    password => $password,
    host     => '%',
    grant    => ['SELECT', 'UPDATE'],
  }
}

Rgbank::Db produces Mysql {
  name     => $db_name,
  user     => $user,
  host     => $::fqdn,
  password => $password
}
