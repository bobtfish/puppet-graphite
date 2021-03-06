# == Class: graphite::install::packages
#
# This class installs graphite packages via pip
#
# === Parameters
#
# None.
#
class graphite::install::package (
      
      )inherits graphite::params {

  package{'graphite-web':
    ensure   => $graphite::graphite_version,
  }->
  package{'carbon':
    ensure   => $graphite::carbon_version,
  }->
  package{'whisper':
    ensure   => $graphite::whisper_version,
  }->

  # workaround for unusual graphite install target:
  # https://github.com/graphite-project/carbon/issues/86
  file { $graphite::params::carbin_pip_hack_source :
    ensure => link,
    target => $::graphite::params::carbin_pip_hack_target,
  }->
  file { $graphite::params::gweb_pip_hack_source :
    ensure => link,
    target => $::graphite::params::gweb_pip_hack_target,
  }

}
