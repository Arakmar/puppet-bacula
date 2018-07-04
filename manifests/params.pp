# Class: bacula::params
#
# Set some platform specific paramaters.
#
class bacula::params {

  $file_retention = '45 days'
  $job_retention  = '6 months'
  $autoprune      = 'yes'
  $monitor        = true
  $ssl            = hiera('bacula::params::ssl', false)
  $ssl_dir        = hiera('bacula::params::ssl_dir', '/etc/puppetlabs/puppet/ssl')
  $device_seltype = 'bacula_store_t'

  validate_bool($ssl)

  $storage          = hiera('bacula::params::storage', $::fqdn)
  $director         = hiera('bacula::params::director', $::fqdn)
  $director_address = hiera('bacula::params::director_address', $director)
  $job_tag          = hiera('bacula::params::job_tag', '')

  case $facts['operatingsystem'] {
    'Ubuntu','Debian': {
      $bacula_common_packages   = [ 'bareos-common' ]
      $bacula_director_packages = [ 'bareos-director', 'bareos-bconsole' ]
      $bacula_director_services = [ 'bareos-director' ]
      $bacula_storage_packages  = [ 'bareos-storage' ]
      $bacula_storage_services  = [ 'bareos-storage' ]
      $bacula_client_packages   = 'bareos-filedaemon'
      $bacula_client_services   = 'bareos-filedaemon'
      $conf_dir                 = '/etc/bareos'
      $bacula_dir               = '/etc/bareos/ssl'
      $client_config            = '/etc/bareos/bareos-fd.conf'
      $homedir                  = '/var/lib/bareos'
      $rundir                   = '/var/run/bareos'
      $plugindir                = '/usr/lib/bareos/plugins'
      $bacula_user              = 'bareos'
      $bacula_group             = $bacula_user
    }
    'SLES': {
      $bacula_common_packages   = [ 'bareos-common' ]
      $bacula_director_packages = [ 'bareos-director', 'bareos-bconsole' ]
      $bacula_director_services = [ 'bareos-director' ]
      $bacula_storage_packages  = [ 'bareos-storage' ]
      $bacula_storage_services  = [ 'bareos-storage' ]
      $bacula_client_packages   = 'bareos-filedaemon'
      $bacula_client_services   = 'bareos-filedaemon'
      $conf_dir                 = '/etc/bareos'
      $bacula_dir               = '/etc/bareos/ssl'
      $client_config            = '/etc/bareos/bareos-fd.conf'
      $homedir                  = '/var/lib/bareos'
      $rundir                   = '/var/run'
      $plugindir                = '/usr/lib64/bareos/plugins'
      $bacula_user              = 'bareos'
      $bacula_group             = $bacula_user
    }
    'RedHat','CentOS','Fedora','Scientific': {
      $bacula_common_packages   = [ 'bareos-common' ]
      $bacula_director_packages = [ 'bareos-director', 'bareos-bconsole' ]
      $bacula_director_services = [ 'bareos-director' ]
      $bacula_storage_packages  = [ 'bareos-storage' ]
      $bacula_storage_services  = [ 'bareos-storage' ]
      $bacula_client_packages   = 'bareos-filedaemon'
      $bacula_client_services   = 'bareos-filedaemon'
      $conf_dir                 = '/etc/bareos'
      $bacula_dir               = '/etc/bareos/ssl'
      $client_config            = '/etc/bareos/bareos-fd.conf'
      $homedir                  = '/var/lib/bareos'
      $rundir                   = '/var/run'
      $plugindir                = '/usr/lib64/bareos/plugins'
      $bacula_user              = 'bareos'
      $bacula_group             = $bacula_user
    }
    'Archlinux': {
      $bacula_common_packages   = [ 'bareos-common' ]
      $bacula_director_packages = [ 'bareos-director', 'bareos-bconsole' ]
      $bacula_director_services = [ 'bareos-director' ]
      $bacula_storage_packages  = [ 'bareos-storage' ]
      $bacula_storage_services  = [ 'bareos-storage' ]
      $bacula_client_packages   = 'bareos-filedaemon'
      $bacula_client_services   = 'bareos-filedaemon'
      $conf_dir                 = '/etc/bareos'
      $bacula_dir               = '/etc/bareos/ssl'
      $client_config            = '/etc/bareos/bareos-fd.conf'
      $homedir                  = '/var/lib/bareos'
      $rundir                   = '/var/run'
      $plugindir                = '/usr/lib/bareos/plugins'
      $bacula_user              = 'bareos'
      $bacula_group             = $bacula_user
    }
    default: { fail("bacula::params has no love for ${facts['operatingsystem']}") }
  }

  $certfile = "${conf_dir}/ssl/${::clientcert}_cert.pem"
  $keyfile  = "${conf_dir}/ssl/${::clientcert}_key.pem"
  $cafile   = "${conf_dir}/ssl/ca.pem"
}
