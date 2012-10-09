class logstash::server (
  
) inherits logstash {

  file { "/etc/cron.daily/logstash.sh":
    ensure => file,
    owner => root,
    group => root,
    mode => 0755,
    source => "puppet:///modules/logstash/cron.daily"
  }
    
  logstash::output::elasticsearch { 'elasticsearch': }
  
}