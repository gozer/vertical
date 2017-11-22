# Required Packages
package { 'sysstat':
  ensure => 'latest',
}

package { 'mcelog':
  ensure => 'latest',
}

package { 'gdb':
  ensure => 'latest',
}

package { 'unzip':
  ensure => 'latest',
}

package { 'nmap':
  ensure => 'latest',
}

package { 'dialog':
  ensure => 'latest',
}

python::pip { 'awscli':
  ensure  => 'latest',
}

# System tuning

sysctl { 'vm.swappiness': 
  value => '1' 
}

file { "/etc/nubis.d/$project_name":
  ensure => file,
  owner  => root,
  group  => root,
  mode   => '0755',
  source => 'puppet:///nubis/files/startup',
}

file { "/usr/local/bin/vertical-bootstrap":
  ensure => file,
  owner  => root,
  group  => root,
  mode   => '0755',
  source => 'puppet:///nubis/files/bootstrap',
}

include nubis_discovery

# Switch to MC port once working
nubis::discovery::service { $project_name:
  tcp      => 'localhost:5450',
}

