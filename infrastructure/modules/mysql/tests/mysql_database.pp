$mysql_root_pw='password'
include mysql::server
mysql_database{['test1', 'test2', 'test3']:
#  ensure => absent,
  ensure => present,
  args   => 'character set utf8',
#  require => Class['mysql::server'],
}
mysql_database{'test4':
  ensure => present,
}
