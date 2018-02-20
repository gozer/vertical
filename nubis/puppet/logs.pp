class { 'fluentd':
  service_ensure => stopped
}

fluentd::configfile { $project_name: }

fluentd::source { 'node-output':
  configfile  => $project_name,
  type        => 'tail',
  format      => 'none ',

  tag         => "forward.$project_name.startup",
  config      => {
    'read_from_head' => true,
    'path'           => "/var/log/vertical-startup.log",
    'pos_file'       => "/var/log/vertical-startup.pos",
  },
}
