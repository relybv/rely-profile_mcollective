# == Class: profile_mcollective
#
# Full description of class profile_mcollective here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class profile_mcollective
(
  $monitor_address = $::profile_mcollective::params::monitor_address,
) inherits ::profile_mcollective::params {

  if $monitor_address != undef {
    validate_string($monitor_address)
  }

  class { '::profile_mcollective::install': }
  -> class { '::profile_mcollective::config': }
  ~> class { '::profile_mcollective::service': }
  -> Class['::profile_mcollective']
}
