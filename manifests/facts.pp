class profile_mcollective::facts ()
{
  #The facts.yaml file resource is generated in its own dedicated class
  #By doing this, the file produced isn't polluted with unwanted in scope class variables.

  ##Bring in as many variables as you want from other classes here.
  #This makes them available to mcollective for use in filters.
  #eg
  #$class_variable = $class::variable

  #mcollective doesn't work with arrays, so use the puppet-stdlib join function
  #eg
  #$ntp_servers = join($ntp::servers, ",")

  # prevent direct use of subclass
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  file{'/etc/puppetlabs/mcollective/facts.yaml':
    owner   => root,
    group   => root,
    mode    => '0400',
    content => template('profile_mcollective/facts.yaml.erb'),
  }
}
