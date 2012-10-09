define logstash::output::elasticsearch (
  $embedded=true
) {  
  @file { "/etc/logstash/conf.d/output.${title}":
    require => File['/etc/logstash/conf.d'],
    owner => root,
    group => root,
    tag => logstash,
    notify => Service[logstash],
    content => template("${module_name}/output/elasticsearch.erb")
  }
}
