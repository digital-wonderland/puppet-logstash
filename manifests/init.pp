class logstash (
  $version = '1.1.1'
) {
  
  #require(java::jre)
  package{'logstash': ensure => installed}
  
  $logstash_jar_path = "/usr/share/logstash/logstash-monolithic.jar"

  file { [ '/opt/logstash', '/etc/logstash', '/etc/logstash/conf.d', '/etc/logstash/patterns' ]:
    ensure => directory,
    owner => root,
    group => root
  }
  
  case $::operatingsystem {
    ubuntu: {
      file { '/etc/init/logstash.conf':
        owner => root,
        group => root,
        mode => 0644,
        require => Package['logstash'],
        content => template('logstash/logstash.init.upstart.erb')
      }
      service { "logstash":
        enable => true,
        ensure => running,
        require => File['/etc/init/logstash.conf']
      }
      logstash::input::file { 'syslog':
        type => 'syslog',
        path => '/var/log/syslog'
      }
      logstash::input::file { 'auth.log':
        type => 'syslog',
        path => '/var/log/auth.log'
      }
    }
    opensuse: {
      file { '/lib/systemd/system/logstash.service':
		    owner => root,
		    group => root,
		    mode => 0750,
        require => Package['logstash'],
		    content => template('logstash/logstash.init.systemd.erb')
		  }
		  service { "logstash":
        enable => true,
        ensure => running,
        name => 'logstash.service',
        provider => systemd,
        require => File['/lib/systemd/system/logstash.service']
      }
		  logstash::input::file { 'syslog':
		    type => 'syslog',
		    path => '/var/log/messages'
		  }
	  }
    default: {
      $supported = false
      notify { "${module_name}_unsupported":
        message => "The ${module_name} module is not supported on ${::operatingsystem}",
      }
    }
	}
  
  logstash::filter::grok { 'syslog':
    pattern => '%{SYSLOGLINE}',
    type => 'syslog'
  }
  
  File <| tag == logstash |>
  
  File <| tag == logstash-filter |>
  
}
