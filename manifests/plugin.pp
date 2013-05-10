# == Class: nagios::plugin
#
# Stub class for nagios::plugin
#
define nagios::plugin {
  case $::osfamily {
    'RedHat': {
      $plugins = {
        'disk'       => 'nagios-plugins-disk',
        'fping'      => 'nagios-plugins-fping',
        'linux_raid' => 'nagios-plugins-linux_raid',
        'load'       => 'nagios-plugins-load',
        'nrpe'       => 'nagios-plugins-nrpe',
        'ntp'        => 'nagios-plugins-ntp',
        'openmanage' => 'nagios-plugins-openmanage',
        'oracle'     => 'nagios-plugins-oracle',
        'ping'       => 'nagios-plugins-ping',
        'procs'      => 'nagios-plugins-procs',
        'smtp'       => 'nagios-plugins-smtp',
        'snmp'       => 'nagios-plugins-snmp',
        'ssh'        => 'nagios-plugins-ssh',
        'swap'       => 'nagios-plugins-swap',
        'tcp'        => 'nagios-plugins-tcp',
        'time'       => 'nagios-plugins-time',
      }
    }
    default: {
      fail( "unsupported osfamily - ${::osfamily}" )
    }
  }

  package { $plugins[$name]: ensure => 'installed' }
}
