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
}
