# == Class: nagios::plugin::nrpe
#
# Installs NRPE plugin (check_nrpe)
#
class nagios::plugin::nrpe {
  nagios::plugin { 'nrpe': }
}
