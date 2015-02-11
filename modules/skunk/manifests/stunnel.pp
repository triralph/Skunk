class skunk::stunnel {

    Package { ensure => 'installed' }

    package { 'stunnel': }
    package { 'libssl': }
    package { 'openssl': }

$stnl       = 'stunnel'
$stnl_conf  = '/etc/stunnel/stunnel.conf'
$stnl_pem   = '/etc/stunnel/stunnel.pem'
$stnl_crt   = '/etc/stunnel/server.crt'
$stnl_dir   = '/etc/stunnel'
$stnl_start = '/usr/sbin/stunnel'
$loader     = '/etc/init.d/stunnel'

    file { $stnl_dir:
                ensure  => directory
          	  	}

    file { $stnl_start:
	              ensure  => file,
			          source  => "puppet:///modules/skunk/stunnel",
			          mode    => '0755'
			          }

    file { $stnl_pem:
                ensure  => file,
                source  => "puppet:///modules/skunk/stunnel.pem",
                mode    => '0644'
          	    }

    file { $stnl_conf:
	              ensure  => file,
	              source  => "puppet:///modules/skunk/stunnel.conf",
				        notify  => Exec[[reload]],
	              mode    => '0644'
	   	 		      }

    file { $stnl_crt:
		            ensure  => file,
		            source  => "puppet:///modules/skunk/server.crt",
		            mode    => '0755'
		            }

    file { $loader:
	              ensure  => file,
				        source => "puppet:///modules/stunnel/stunnel-loader",
			          }

                service { $stnl:
	                     ensure    => running,
	                     subscribe => File[$stnl_conf],
	      		           }

                       exec { "reload":
			                      command     => "/etc/init.d/stunnel restart",
			                      refreshonly => true,
			                      require     => Service[[$stnl]],
		                        }
}
