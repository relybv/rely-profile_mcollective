# == Class profile_mcollective::install
#
# This class is called from profile_mcollective for install.
#
class profile_mcollective::install {
  # prevent direct use of subclass
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  if $profile_mcollective::monitor_address == undef {
    $monitor_address = localhost
  } else {
    $monitor_address = $profile_mcollective::monitor_address
  }

  # create fact file
  class {'profile_mcollective::facts':}

  # install middleware to monitor server
  if $profile_mcollective::monitor_address == 'localhost' {
    class {'::rabbitmq':
      delete_guest_user => true,
      config_stomp      => true,
      stomp_ensure      => true,
      stomp_port        => 61613,
    }
  }

  ensure_packages({'puppet-agent' => { ensure => 'present' }})
  ensure_packages({'mcollective-plugins-service' => { ensure => 'present' }})
  ensure_packages({'python' => { ensure => 'present' }})

  # install mcollective plugins
  file {'/opt/puppetlabs/mcollective/plugins/mcollective/':
    source  => 'puppet:///modules/profile_mcollective/plugins/',
    recurse => true,
  }
}
