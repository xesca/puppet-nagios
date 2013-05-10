# == Class: nagios::plugin::disk
#
# Installs Nagios disk plugin (check_disk)
#
class nagios::plugin::disk {
  nagios::plugin { 'disk': }
}
