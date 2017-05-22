# == Class profile_mcollective::params
#
# This class is meant to be called from profile_mcollective.
# It sets variables according to platform.
#
class profile_mcollective::params {
  $monitor_address = $::monitor_address
  case $::osfamily {
    'Debian': {
      $package_name = 'profile_mcollective'
      $service_name = 'profile_mcollective'
    }
    'RedHat', 'Amazon': {
      $package_name = 'profile_mcollective'
      $service_name = 'profile_mcollective'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
