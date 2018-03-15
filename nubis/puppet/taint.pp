# Overloaded Wrapper to actually perform the tainting conditionally
# These should be part of nubis-base

# https://github.com/nubisproject/nubis-base/issues/791
file {'/usr/local/sbin/nubis-taint':
  ensure => file,
  owner  => root,
  group  => root,
  mode   => '0755',
  source => 'puppet:///nubis/files/nubis-taint',
}

# https://github.com/nubisproject/nubis-base/issues/793
file {'/usr/local/sbin/nubis-taint-reap':
  ensure => file,
  owner  => root,
  group  => root,
  mode   => '0755',
  source => 'puppet:///nubis/files/nubis-taint-reap',
}

# Disable instance tainted for this system automation account
file { '/home/dbadmin/.no-taint':
  ensure  => file,
  owner   => root,
  group   => root,
  mode    => '0644',
  content => 'Disable instance tainted for this system automation account',
}
