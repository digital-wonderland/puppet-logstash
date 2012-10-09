define logstash::output::redis(
  $host='127.0.0.1',
  $key='logstash'
) {
    
  @file { "/etc/logstash/conf.d/output.${title}":
    require => File['/etc/logstash/conf.d'],
    owner => root,
    group => root,
    tag => logstash,
    notify => Service[logstash],
    content => template("${module_name}/output/redis.erb")
  }
}