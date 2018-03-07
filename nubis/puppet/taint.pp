# Overloaded Wrapper to actually perform the tainting conditionally

file {'/usr/local/sbin/nubis-taint':
  ensure => file,
  owner  => root,
  group  => root,
  mode   => '0755',
  source => 'puppet:///nubis/files/nubis-taint',
}

file { '/home/dbadmin/.no-taint':
  ensure  => file,
  owner   => root,
  group   => root,
  mode    => '0644',
  content => 'Disable instance tainted for this system automation account',
}
