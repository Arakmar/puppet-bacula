# = Class: bacula::common
#
# == Description
#
# This class configures and installs the bacula common packages and enables
# the service, so that bacula jobs can be run on the client including this
# manifest.
#
class bacula::common (
  $homedir      = $bacula::params::homedir,
  $homedir_mode = '0770',
  $packages     = $bacula::params::bacula_common_packages,
  $user         = $bacula::params::bacula_user,
  $group        = $bacula::params::bacula_group,
) inherits bacula::params {

  include bacula::ssl

  ensure_packages($packages, {'tag' => 'bareos'})

  file { $conf_dir:
    ensure  => 'directory',
    owner   => $user,
    group   => $group,
    purge   => true,
    force   => true,
    recurse => true,
  }

  Package <| tag == 'bareos' |> -> File[$conf_dir]

  file { $homedir:
    ensure  => directory,
    owner   => $user,
    group   => $group,
    mode    => $homedir_mode,
    require => Package[$packages],
  }
}
