define bacula::director::console(
    $password,
    $profile,
    $conf_dir = $bacula::params::conf_dir,
) {
    concat::fragment { "bacula-director-console-${title}":
        target  => "${conf_dir}/conf.d/client.conf",
        content => template('bacula/bacula-dir-console.erb'),
    }
}