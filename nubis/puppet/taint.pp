# Disable instance tainted for this system automation account
file { '/home/dbadmin/.no-taint':
  ensure  => file,
  owner   => root,
  group   => root,
  mode    => '0644',
  content => 'Disable instance tainted for this system automation account',
}
