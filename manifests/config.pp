# == Class profile_mcollective::config
#
# This class is called from profile_mcollective for service config.
#
class profile_mcollective::config {
  # prevent direct use of subclass
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

}
