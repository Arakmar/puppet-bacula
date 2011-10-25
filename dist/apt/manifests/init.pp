class apt {

  case $operatingsystem {
    debian,ubuntu: {

      $apt_dir = "/etc/apt"
      $sources_dir = "${apt_dir}/sources.list.d"

      exec {
        "apt-get update":
          user        => root,
          command     => "/usr/bin/apt-get -qq update",
          refreshonly => true;
      }

      cron { "apt-get update":
        command => "/usr/bin/apt-get -qq update",
        user    => root,
        minute  => 20,
        hour    => 1,
      }

      file {
        "sources.list.d":
          path     => "${sources_dir}",
          ensure   => directory,
          owner    => root,
          group    => root,
          mode     => 0755;
        "${apt_dir}/sources.list":
          ensure => absent;
      }
    }
    default: {
      err("apt_defaults class is for Debian-derived systems.")
      err("${fqdn} runs ${operatingsystem}.")
    }
  }

}

