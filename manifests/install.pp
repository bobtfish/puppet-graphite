# == Class: graphite::install
#
# This class installs graphite packages via pip
#
# === Parameters
#
# None.
#
class graphite::install(
  $django_tagging_ver = '0.3.1',
  $twisted_ver = '11.1.0',
  $txamqp_ver = '0.4',
) inherits graphite::params {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  if $graphite::use_packages == true {
    include graphite::install::package
  } else {
    include graphite::install::source
  }
  
  exec { 'Initial django db creation':
    creates     => "${graphite::storage_dir}/graphite.db",
    command     => '/usr/bin/python manage.py syncdb --noinput',
    cwd         => "${graphite::install_dir}/webapp/graphite",
    require     => [
                    File["${graphite::install_dir}/webapp/graphite/local_settings.py"],
                    Exec['Chown graphite storage for web user']
                   ];
  }
}
