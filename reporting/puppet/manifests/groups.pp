node_group { 'Mac Laptops':
  environment          => 'production',
  parent               => 'All Nodes',
  rule                 => [ "or", [ "=", "kernel", "Darwin"] ],
}
