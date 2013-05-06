class nagios::service {
  service { $nagios::service:
    ensure => $nagios::service_ensure_real,
    enable => $nagios::service_enable_real,
  }
}
