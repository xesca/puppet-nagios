# == Class: nagios::params
#
# Params class for nagios
#
class nagios::params {
  case $::osfamily {
    'RedHat': {
      $service = 'nagios'
      $package =
        [
          'nagios',
          'nagios-plugins-disk',
          'nagios-plugins-http',
          'nagios-plugins-load',
          'nagios-plugins-nrpe',
          'nagios-plugins-ntp',
          'nagios-plugins-ping',
          'nagios-plugins-procs',
          'nagios-plugins-tcp',
          'nagios-plugins-swap',
          'nagios-plugins-ssh',
          'nagios-plugins-users',
        ]
      $cgi_cfg = '/etc/nagios/cgi.cfg'
      $daemon_user = 'nagios'
      $ext_cmd_group = 'apache'
      $valid_debug_level_re = '^(-1|[0-3]?[0-9]{1,3}|40[0-8][0-9]|409[0-5])$'
      $nagios_cfg = '/etc/nagios/nagios.cfg'

      # PARAMETERS FOR nagios.cfg
      # We define all the defaults according to a fresh install from EPEL
      # on RHEL6.  Most of the parameters are included here, and the ones
      # left out are lesser used, and can be added in later if need-be.

      $accept_passive_host_checks = true
      $accept_passive_service_checks = true
      $admin_email = 'nagios@localhost'
      $admin_pager = 'pagenagios@localhost'
      $bare_update_check = false
      $check_for_orphaned_hosts = true
      $check_for_orphaned_services = true
      $check_result_path = '/var/log/nagios/spool/checkresults'
      $check_result_reaper_frequency = '10'
      $command_file = '/var/spool/nagios/cmd/nagios.cmd'
      $cfg_dir = [ ]
      $cfg_file =
        [
          '/etc/nagios/objects/commands.cfg',
          '/etc/nagios/objects/contacts.cfg',
          '/etc/nagios/objects/timeperiods.cfg',
          '/etc/nagios/objects/templates.cfg',
          '/etc/nagios/objects/localhost.cfg',
        ]
      $debug_file = '/var/log/nagios/nagios.debug'
      $debug_level = '0'
      $enable_environment_macros = true
      $enable_event_handlers = true
      $enable_notifications = true
      $event_handler_timeout = '30'
      $execute_host_checks = true
      $execute_service_checks = true
      $host_check_timeout = '30'
      $log_archive_path = '/var/log/nagios/archives'
      $log_event_handlers = true
      $log_external_commands = true
      $log_file = '/var/log/nagios/nagios.log'
      $log_host_retries = true
      $log_initial_states = true
      $log_notifications = true
      $log_passive_checks = true
      $log_service_retries = true
      $max_check_result_file_age = '3600'
      $max_check_result_reaper_time = '30'
      $max_concurrent_checks = '0'
      $max_debug_file_size = '1000000'
      $max_host_check_spread = '30'
      $max_service_check_spread = '30'
      $notification_timeout = '30'
      $object_cache_file = '/var/log/nagios/objects.cache'
      $ocsp_timeout = '5'
      $perfdata_timeout = '5'
      $precached_object_file = '/var/log/nagios/objects.precache'
      $process_performance_data = false
      $retain_state_information = true
      $retention_update_interval = '60'
      $service_check_timeout_state = 'c'
      $service_check_timeout = '60'
      $state_retention_file = '/var/log/nagios/retention.dat'
      $status_file = '/var/log/nagios/status.dat'
      $temp_file = '/var/log/nagios/nagios.tmp'
      $use_large_installation_tweaks = false
      $use_retained_program_state = true
      $use_retained_scheduling_info = true
      $use_syslog = true
      $p1_file = '/usr/sbin/p1.pl'
    }
    'Debian': {
      $service = 'nagios3'
      $package =
        [
          'nagios3',
          'nagios3-cgi',
          'nagios3-common',
          'nagios3-core',
          'nagios-plugins',
          'nagios-images',
        ]
      $cgi_cfg = '/etc/nagios3/cgi.cfg'
      $daemon_user = 'nagios3'
      $ext_cmd_group = 'apache'
      $valid_debug_level_re = '^(-1|[0-3]?[0-9]{1,3}|40[0-8][0-9]|409[0-5])$'
      $nagios_cfg = '/etc/nagios3/nagios.cfg'

      # PARAMETERS FOR nagios.cfg
      # We define all the defaults according to a fresh install from EPEL
      # on RHEL6.  Most of the parameters are included here, and the ones
      # left out are lesser used, and can be added in later if need-be.

      $accept_passive_host_checks = true
      $accept_passive_service_checks = true
      $admin_email = 'nagios@localhost'
      $admin_pager = 'pagenagios@localhost'
      $bare_update_check = false
      $check_for_orphaned_hosts = true
      $check_for_orphaned_services = true
      $check_result_path = '/var/lib/nagios3/spool/checkresults'
      $check_result_reaper_frequency = '10'
      $command_file = '/var/lib/nagios3/rw/nagios.cmd'
      $cfg_dir = [ '/etc/nagios3/conf.d', '/etc/nagios-plugins/config' ]
      $cfg_file =
        [
          '/etc/nagios3/commands.cfg',
        ]
      $debug_file = '/var/log/nagios3/nagios.debug'
      $debug_level = '0'
      $enable_environment_macros = true
      $enable_event_handlers = true
      $enable_notifications = true
      $event_handler_timeout = '30'
      $execute_host_checks = true
      $execute_service_checks = true
      $host_check_timeout = '30'
      $log_archive_path = '/var/log/nagios3/archives'
      $log_event_handlers = true
      $log_external_commands = true
      $log_file = '/var/log/nagios3/nagios.log'
      $log_host_retries = true
      $log_initial_states = true
      $log_notifications = true
      $log_passive_checks = true
      $log_service_retries = true
      $max_check_result_file_age = '3600'
      $max_check_result_reaper_time = '30'
      $max_concurrent_checks = '0'
      $max_debug_file_size = '1000000'
      $max_host_check_spread = '30'
      $max_service_check_spread = '30'
      $notification_timeout = '30'
      $object_cache_file = '/var/cache/nagios3/objects.cache'
      $ocsp_timeout = '5'
      $p1_file = '/usr/lib/nagios3/p1.pl'
      $perfdata_timeout = '5'
      $precached_object_file = '/var/cache/nagios3/objects.precache'
      $process_performance_data = false
      $resource_file = ['/etc/nagios3/resource.cfg',]
      $retain_state_information = true
      $retention_update_interval = '60'
      $service_check_timeout_state = 'c'
      $service_check_timeout = '60'
      $state_retention_file = '/var/lib/nagios3/retention.dat'
      $status_file = '/var/lib/nagios3/status.dat'
      $temp_file = '/var/lib/nagios3/nagios.tmp'
      $use_large_installation_tweaks = false
      $use_retained_program_state = true
      $use_retained_scheduling_info = true
      $use_syslog = true
    }
  }
}
