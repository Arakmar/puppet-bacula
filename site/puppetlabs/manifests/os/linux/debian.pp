class puppetlabs::os::linux::debian  {
  include puppetlabs::os::linux

  include harden

  case $domain {
    "puppetlabs.lan": {
      # Setup apt settings specific to the lan
      class { "apt::settings": proxy => hiera("proxy"); }
    }
    "puppetlabs.com": {
    }
    default: { }
  }

  $packages = [
    'lsb-release',
    'keychain',
    'ca-certificates',
  ]

  package { $packages: ensure => latest; }

  exec {
    "import puppet labs apt key":
      user    => root,
      command => "/usr/bin/wget -q -O - http://apt.puppetlabs.com/debian/4BD6EC30.asc | apt-key add -",
      unless  => "/usr/bin/apt-key list | grep -q 4BD6EC30",
      before  => Exec["apt-get update"];
  }

  # For some reason, we keep getting mpt installed on things. Not
  # cool.
  if $is_virtual == 'true' {
    package{ 'mpt-status':
      ensure => purged,
    }
  }

  ####
  # APT REPO SHIT
  #
  apt::source { "puppetlabs_ops.list":
    ensure       => absent,
    uri          => "http://apt.puppetlabs.com/ops",
    distribution => "sid"
  }

  apt::source {
    "security.list":
      uri       => $lsbdistid ? {
        "debian" => "http://security.debian.org/",
        "ubuntu" => "http://security.ubuntu.com/ubuntu",
      },
      distribution => $lsbdistid ? {
        "debian" => "${lsbdistcodename}/updates",
        "ubuntu" => "${lsbdistcodename}-security",
      },
      component => $lsbdistid ? {
        "debian" => "main",
        "ubuntu" => "main universe",
      },
  }

  apt::source { "puppetlabs.list":
    uri          => $lsbdistid ? {
      "debian" => "http://apt.puppetlabs.com/debian",
      "ubuntu" => "http://apt.puppetlabs.com/ubuntu",
    }
  }

  apt::source { "updates.list":
    uri          => $lsbdistid ? {
      "debian" => "http://ftp.us.debian.org/debian/",
      "ubuntu" => "http://us.archive.ubuntu.com/ubuntu/",
    },
    distribution => "${lsbdistcodename}-updates",
    component => $lsbdistid ? {
      "debian" => "main",
      "ubuntu" => "universe",
    },
  }

  # Debian Specific things
  case $operatingsystem {
    Debian: {
      apt::source { "main.list": }

    }
    default: { }
  }

}

