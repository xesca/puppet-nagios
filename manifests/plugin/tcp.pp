# == Class: nagios::plugin::tcp
#
# Installs the check_tcp plugin
#
class nagios::plugin::tcp {
  nagios::plugin { 'tcp': }
}
