# Class: openstack-nova
#
# This module manages openstack-nova
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
class openstack-nova {
  Package { ensure => present }
  Exec { path => "/usr/bin" }

  package { [ 'lvm2', 'rabbitmq-server', 'python-software-properties'] : }

  # add-apt-repository is part of python-software-properties
  exec { 'nova-core-ppa' :
    command => 'add-apt-repository ppa:nova-core/release',
    require => Package['python-software-properties'],
  }
  package { ['python-nova'] :
    require => Exec['nova-core-ppa'],
  }

  # According to some docs the python-nova package doesn't have it's dependencies declared correctly
  # so we need to require it first
  package { [
      'nova-common',
      'nova-doc',
      'nova-api',
      'nova-network',
      'nova-objectstore',
      'nova-scheduler',
      'nova-compute',
      'euca2ools',
      'unzip'
    ] :
    require => Package['python-nova'],
  }
}
