# == Class: nagios::plugin::procs
#
# Installs the check_procs plugin
#
class nagios::plugin::procs {
  nagios::plugin { 'procs': }
}
