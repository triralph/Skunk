class autofs {

	package { 'autofs':
        ensure  => 'installed',
				enabled => 'true',
		    }

file { '/etc/auto.master':
           ensure  => file,
           source  => "puppet:///modules/autofs/auto.master",
           group   => 'root',
           mode    => '0644'
           }

file { '/etc/auto.direct':
           ensure  => file,
           source  => "puppet:///modules/autofs/auto.direct",
           group   => 'root',
           owner   => 'root',
           mode    => '0644'
           }
}
