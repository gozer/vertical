class { 'fluentd':
  service_ensure => stopped
}

fluentd::configfile { $project_name: }

fluentd::source { "${project_name}-startup":
  configfile => $project_name,
  type       => 'tail',
  format     => 'none ',

  tag        => "forward.${project_name}.startup",
  config     => {
    'read_from_head' => true,
    'path'           => '/var/log/vertical-startup.log',
    'pos_file'       => '/var/log/vertical-startup.pos',
  },
}

fluentd::source { "${project_name}-launch":
  configfile => $project_name,
  type       => 'tail',
  format     => 'none ',

  tag        => "forward.${project_name}.launch",
  config     => {
    'read_from_head' => true,
    'path'           => '/var/log/launch.log',
    'pos_file'       => '/var/log/launch.pos',
  },
}

fluentd::source { "${project_name}-autoscale":
  configfile => $project_name,
  type       => 'tail',
  format     => 'none ',

  tag        => "forward.${project_name}.autoscale",
  config     => {
    'read_from_head' => true,
    'path'           => '/home/dbadmin/autoscale/*.log',
    'pos_file'       => '/home/dbadmin/autoscale/autoscale.pos',
  },
}

fluentd::source { "${project_name}-vertica":
  configfile => $project_name,
  type       => 'tail',
  format     => 'none ',

  tag        => "forward.${project_name}.logs",
  config     => {
    'read_from_head' => true,
    'path'           => '/opt/vertica/log/*.log',
    'pos_file'       => '/opt/vertica/log/all.pos',
  },
}
