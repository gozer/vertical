package { 'sysstat':
  ensure => 'latest',
}

package { 'mcelog':
  ensure => 'latest',
}

package { 'gdb':
  ensure => 'latest',
}

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
