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

  mysql_user { "${user}@localhost":
    ensure   => 'present',
    password_hash => mysql_password($password),
  }
}

Rgbank::Db produces Mysqldb {
  database => "rgbank-${name}",
  user     => $user,
  host     => $::hostname,
  password => $password
}
