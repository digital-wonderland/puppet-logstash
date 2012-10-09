define logstash::input::file (
  $path,
  $type,
  $tags=undef,
  $fields=undef
) {
  # ubuntu overwrites $type in templates
  $logstash_type = $type
  $logstash_tags = $tags
  
  @file { "/etc/logstash/conf.d/input.${title}":
    require => File['/etc/logstash/conf.d'],
    owner => root,
    group => root,
    tag => logstash,
    notify => Service[logstash],
    content => template("${module_name}/input/file.erb")
  }
}
