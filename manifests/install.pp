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
  notify {"Mco middleware address ${profile_mcollective::monitor_address} ":}

  if $profile_mcollective::monitor_address == 'localhost' {
    notify {'Installing rabbitmq as middleware':}
    class { '::rabbitmq':
      delete_guest_user => true,
      config_stomp      => true,
      stomp_ensure      => true,
      stomp_port        => 61613,
    }
  }

  ensure_packages({'puppet-agent' => { ensure => 'present' }})

}
