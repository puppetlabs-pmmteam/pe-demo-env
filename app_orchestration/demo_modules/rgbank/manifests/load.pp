define rgbank::load (
  $balancemembers,
) {
}

$balancemembers.each |$i| {
  notify { "Adding ${i['ip']} to the balance pool": }
  #haproxy::balancemember {
  #  ip => Http['htp-lb-dev-1']['ipaddress']
  #}
}

Rgbank::Load produces Http { }
Rgbank::Load consumes Http { }
