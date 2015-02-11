class corosync{
	 package { 'corosync':
    ensure => '1.4.1',
             }

       file { '/etc/corosync/authkey':
                ensure  => present,
                source  => "puppet://modules/corosync/authkey",
                owner   => 'root',
                group   => 'root',
                mode    => '0400',
                notify  => Service['corosync']
                require => Package['corosync'],
                }

       file { '/etc/corosync/corosync.conf':
                ensure  => present,
                source  => "puppet://modules/corosync/corosync.conf",
	            owner   => 'root',
                group   => 'root',
                mode    => "0644"
                require => Package['corosync'],
                }
            
       file { '/etc/corosync/service.d':
                ensure  => directory,
                mode    => '0755',
                owner   => 'root',
                group   => 'root',
                recurse => true,
                purge   => true,
                require => Package['corosync']
                }
             
       service { 'corosync':
                ensure    => running,
                enable    => true,
                subscribe => File[ [ '/etc/corosync/corosync.conf', '/etc/corosync/service.d' ] ],
                }
}
