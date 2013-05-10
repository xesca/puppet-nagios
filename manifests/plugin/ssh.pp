# == Class: nagios::plugin::ssh
#
# Installs the check_ssh nagios plugin
#
class nagios::plugin::ssh {
  nagios::plugin { 'ssh': }
}
