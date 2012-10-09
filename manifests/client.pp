class logstash::client (
    $host,
    $transport=redis
  ) inherits logstash {
  
  case $transport {
    redis: {
      logstash::output::redis { 'redis':
        host => $host
      }
    }
    default: {
      $supported = false
      notify { "${module_name}_unsupported":
        message => "The transport [${transport}] is not supported",
      }
    }    
  }
  
}