define bacula::director::profile(
    $command_acl = '*all*',
    $job_acl = '*all*',
    $schedule_acl = '*all*',
    $catalog_acl = '*all*',
    $pool_acl = '*all*',
    $storage_acl = '*all*',
    $client_acl = '*all*',
    $fileset_acl = '*all*',
    $where_acl = '*all*',
    $conf_dir = $bacula::params::conf_dir,
) {
    concat::fragment { "bacula-director-profile-${title}":
        target  => "${conf_dir}/conf.d/profile.conf",
        content => template('bacula/bacula-dir-profile.erb'),
    }
}