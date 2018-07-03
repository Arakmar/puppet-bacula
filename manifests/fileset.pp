# Define: bacula::fileset
#
# A grouping of files to backup.
#
define bacula::fileset (
  $files,
  $excludes                     = '',
  Hash[String, String] $options = {'signature' => 'SHA1', 'compression' => 'GZIP9'},
  $plugin                       = undef,
  $conf_dir                     = $bacula::params::conf_dir, # Overridden at realize
  $director                     = $bacula::params::director,
) {

  include bacula::common

  @@concat::fragment { "bacula-fileset-${name}":
    target  => "${conf_dir}/conf.d/fileset.conf",
    content => template('bacula/fileset.conf.erb'),
    tag     => "bacula-${director}",
  }
}
