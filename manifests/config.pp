# == Class profile_mcollective::config
#
# This class is called from profile_mcollective for service config.
#
class profile_mcollective::config {
  # prevent direct use of subclass
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  file { '/etc/puppetlabs/mcollective/server.cfg':
    content => template('profile_mcollective/server.cfg.erb'),
    owner   => root,
    group   => root,
    mode    => '0644',
    notify  => Exec['mcollective'],
  }

  file { '/etc/puppetlabs/mcollective/client.cfg':
    content => template('profile_mcollective/client.cfg.erb'),
    owner   => root,
    group   => root,
    mode    => '0644',
  }

  rabbitmq_vhost { 'mcollective':
    ensure => present,
  }

  rabbitmq_user { 'mcollective':
    admin    => false,
    password => 'changeme',
    tags     => ['monitoring', 'tag1'],
  }

  rabbitmq_user { 'admin':
    admin    => true,
    password => 'changeme',
  }

  rabbitmq_user_permissions { 'mcollective@mcollective':
    configure_permission => '.*',
    read_permission      => '.*',
    write_permission     => '.*',
  }

  rabbitmq_user_permissions { 'admin@mcollective':
    configure_permission => '.*',
    read_permission      => '.*',
    write_permission     => '.*',
  }

  rabbitmq_exchange { 'mcollective_broadcast@mcollective':
    ensure   => present,
    user     => 'mcollective',
    password => 'changeme',
    type     => 'topic',
  }

  rabbitmq_exchange { 'mcollective_directed@mcollective':
    ensure   => present,
    user     => 'mcollective',
    password => 'changeme',
    type     => 'direct',
  }
}
