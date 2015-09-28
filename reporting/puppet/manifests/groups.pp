node_group { 'Mac Laptops':
  environment          => 'production',
  parent               => 'All Nodes',
  rule                 => [ "=", ["fact", "kernel"], "Darwin"],
}
