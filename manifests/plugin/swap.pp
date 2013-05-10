# == nagios::plugin::swap
#
# Installs the check_swap plugin
#
class nagios::plugin::swap {
  nagios::plugin { 'swap': }
}
