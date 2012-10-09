define logstash::filter::grok (
  $pattern,
  $type
) {
  # ubuntu overwrites $type in templates
  $logstash_type = $type
  
  @file { "/etc/logstash/conf.d/filter.${title}":
    require => File['/etc/logstash/conf.d'],
    owner => root,
    group => root,
    tag => logstash-filter,
    notify => Service[logstash],
    content => template("${module_name}/filter/grok.erb")
  }
}
