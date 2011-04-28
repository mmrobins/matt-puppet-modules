# Class: niceties
#
# This module manages niceties
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
class development-niceties {
  Package { ensure => installed }
  package { [ 'vim', 'exuberant-ctags', 'tmux', 'tree'] : }
}
