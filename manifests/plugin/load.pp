# == Class: nagios::plugin::load
#
# Install nagios plugin for load (check_load)
#
class nagios::plugin::load {
  nagios::plugin { 'load': }
}
