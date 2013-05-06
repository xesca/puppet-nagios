class nagios::package {
  package { $nagios::package: ensure => 'installed' }
}
