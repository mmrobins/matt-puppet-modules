# Class: apt-cacher-ng
#
# This module manages apt-cacher-ng
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# [Remember: No empty lines between comments and class definition]
class apt-cacher-ng {
  Package { require => Exec['apt-get update'] }

  package { 'apt-cacher-ng' :
    ensure => installed,
  }

  service { 'apt-cacher-ng' :
    ensure => running,
    require => Package['apt-cacher-ng'],
  }

  # Vagrant specific sharing of cache directory
  # comment out if not using vagrant
  file { '/var/cache/apt-cacher-ng' :
    ensure  => link,
    owner   => 'apt-cacher-ng',
    group   => 'apt-cacher-ng',
    target  => '/vagrant/apt-cacher-ng',
    force   => true,
    require => Package['apt-cacher-ng'],
  }

  # probably ought to make this independent of ubuntu version somehow
  file { '/etc/apt/sources.list' :
    content => template("apt-cacher-ng/sources.list.erb"),
    require => Service['apt-cacher-ng'],
  }

  exec { 'apt-get update' :
    path => '/usr/bin',
  }

  # this should become a defined type or type provider for all the options
  # might need to parse file to add multiple remaps
  file { '/etc/apt-cacher-ng/acng.conf' :
    content => template("apt-cacher-ng/acng.conf.erb"),
    require => Service['apt-cacher-ng'],
  }

# host { 'gb.archive.ubuntu.com' :
#   ensure       => present,
#   host_aliases => ['security.ubuntu.com'],
#   ip           => '127.0.0.1',
#   require      => Service['apt-cacher-ng'],
# }
}
