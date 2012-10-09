define logstash::input::redis(
  $type='redis-input',
  $host='127.0.0.1',
  $key='logstash'
) {
  # buntu overwrites $type in templates
  $logstash_type = $type
  
  @file { "/etc/logstash/conf.d/input.${title}":
    require => File['/etc/logstash/conf.d'],
    owner => root,
    group => root,
    tag => logstash,
    notify => Service[logstash],
    content => template("${module_name}/input/redis.erb")
  }
}