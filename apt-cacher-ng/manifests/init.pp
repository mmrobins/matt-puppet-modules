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
  package {'apt-cacher-ng' :
    ensure => installed,
  }
}
