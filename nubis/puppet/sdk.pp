# Packages needed to build the Vertica SDK examples functions

package { 'gcc-c++':
  ensure => 'present',
}

package { 'zlib-devel':
  ensure => 'present',
}

package { 'bzip2-devel':
  ensure => 'present',
}

package { 'curl-devel':
  ensure => 'present',
}

package { 'bzip2':
  ensure => 'present',
}

package { 'boost-devel':
  ensure => 'present',
}

file { '/usr/local/sbin/nubis-vertica-install-user-defined-functions':
  ensure => file,
  owner  => 'root',
  group  => 'root',
  mode   => '0755',
  source => 'puppet:///nubis/files/user-defined-functions',
}
