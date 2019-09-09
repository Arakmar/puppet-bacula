# Define: bacula::jobdefs
#
# This define adds a jobdefs entry on the bacula director for reference by the client configurations.
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
define bacula::jobdefs (
  $jobtype             = 'Backup',
  $sched               = 'Default',
  $messages            = 'Standard',
  $priority            = '10',
  $pool                = 'Default',
  $level               = undef,
  $accurate            = 'no',
  $reschedule_on_error = false,
  $reschedule_interval = '1 hour',
  $reschedule_times    = '10',
  Array $runscript     = [],
  $allow_duplicate_jobs = undef,
  $cancel_queued_duplicates = undef,
  $cancel_lower_level_duplicates = undef,
  $cancel_running_duplicates = undef,
  $rerun_failed_levels = undef,
  $max_full_interval = undef
) {

  validate_re($jobtype, ['^Backup', '^Restore', '^Admin', '^Verify', '^Copy', '^Migrate'])

  include bacula::params
  $conf_dir = $bacula::params::conf_dir

  concat::fragment { "bacula-jobdefs-${name}":
    target  => "${conf_dir}/conf.d/jobdefs.conf",
    content => template('bacula/jobdefs.conf.erb'),
  }
}
