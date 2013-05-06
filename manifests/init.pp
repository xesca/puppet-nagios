# == Class: Nagios
#
# This class manages the installation of a nagios monitoring server.
# Parameter defaults are based on the distro of installation.
#
# == Parameters:
#
# [*admin_email*]
#   Email address of the Nagios server admin
#
# [*admin_pager*]
#   Pager of the Nagios server admin
#
# [*authorized_for_all_hosts*]
#   Comma separated list of users who are allowed to see all hosts that are
#   being monitored
#
# [*authorized_for_all_host_commands*]
#   Comma separated list of users who can issue commands to all hosts that are
#   being monitored
#
# [*authorized_for_all_services*]
#   Comma separated list of users who are allowed to see all services that are
#   being monitored
#
# [*authorized_for_all_service_commands*]
#   Comma separated list of users who can issue commands to all services that
#   are being monitored
#
# [*authorized_for_configuration_information*]
#   Comma separated list of users who are allowed to see configuration data via
#   the CGI interface
#
# [*authorized_for_system_commands*]
#   Comma separated list of users who are allowed to shutdown/restart and
#   perform other system commands via the CGI interface.
#
# [*authorized_for_system_information*]
#   Comma separated list of users who are allowed to see nagios system process
#   information via the CGI interface
#
# [*cfg_dir*]
#   A list of values, either as an array or comma-seperated, of directories
#   in which Nagios should find configuration files
#
# [*cfg_file*]
#   A list of values, either as an array or comma-seperated, of Nagios
#   configuration files.
#
# [*check_result_path*]
#   Path to folder where check results are stored. Sets check_result_path
#
# [*enable_event_handlers*]
#   Controls whether event handlers are enabled/disabled.
#
# [*enable_notifications*]
#   Controls whether notifications are sent out
#
# [*object_cache_file*]
#   Location of the object cache file.  Sets the object_cache_file option in
#   nagios.cfg
#
# [*precached_object_file*]
#   Location of the precached object file. Sets the precached_object_file option
#   in nagios.cfg
#
# [*resource_file*]
#   Comma separated list of filepaths that contain Nagios resource data.
#
# [*service_enable*]
#   String value of 'on' - Puppet ensures service starts on boot, 'off' - Puppet
#   ensures service is not started on boot, 'undef' - Puppet does nothing.
#
# [*service_ensure*]
#   String value of 'running' - Puppet ensures service is running, 'stopped' -
#   Puppet ensures service is stopped or 'undef' - Puppet does nothing
#
# [*status_file*]
#   Location of Nagios status file.  Sets status_file option in nagios.cfg
#
# [*temp_file*]
#   Location of Nagios temp file.  Sets temp_file option in nagios.cfg
#
# [*temp_path*]
#   Location of Nagios temp path. Sets temp_path option in nagios.cfg
#
# == Examples:
#
# class { 'nagios':
#   admin_email                 => 'op@example.com',
#   admin_pager                 => '5551234567@txt.att.net',
#   enable_event_handlers       => false,
# }
#
# == Notes:
#
# This class assumes you have all your repos figured out, and that they
# are installed via run stages, so they will already be available by the
# time we get to installing packages
#
# On systems running SELinux, you may need to add fcontext entries if you
# change the default file locations.  On RedHat based systems, you can find
# more information on the relevant contexts you need worry about in the
# nagios_selinux manpages.
class nagios (
  $admin_email = params_lookup( 'admin_email', false),
  $admin_pager = params_lookup( 'admin_pager', false),
  $authorized_for_all_hosts =
    params_lookup( 'authorized_for_all_hosts', false ),
  $authorized_for_all_host_commands =
    params_lookup( 'authorized_for_all_host_commands', false ),
  $authorized_for_all_services =
    params_lookup( 'authorized_for_all_services', false ),
  $authorized_for_all_service_commands =
    params_lookup( 'authorized_for_all_service_commands', false ),
  $authorized_for_configuration_information =
    params_lookup( 'authorized_for_configuration_information', false ),
  $authorized_for_system_information =
    params_lookup( 'authorized_for_system_information', false ),
  $authorized_for_system_commands =
    params_lookup( 'authorized_for_system_commands', false ),
  $cfg_dir = params_lookup( 'cfg_dir', false),
  $cfg_file = params_lookup( 'cfg_file', false),
  $check_result_path = params_lookup( 'check_result_path', false),
  $check_result_reaper_frequency =
    params_lookup( 'check_result_reaper_frequency', false),
  $enable_event_handlers = params_lookup( 'enable_event_handlers', false),
  $enable_notifications = params_lookup( 'enable_notifications', false),
  $object_cache_file = params_lookup( 'object_cache_file', false),
  $precached_object_file = params_lookup( 'precached_object_file', false),
  $resource_file = params_lookup( 'resource_file', false),
  $service_ensure = params_lookup( 'service_ensure', false, running),
  $service_enable = params_lookup( 'service_enable', false, true),
  $status_file = params_lookup( 'status_file', false),
  $temp_file = params_lookup( 'temp_file', false),
  $temp_path = params_lookup( 'temp_path', false)
) {

  $service_ensure_real = $service_ensure ? { /^(undef|)$/ =>  undef, 
                                             default => $service_ensure }
  $service_enable_real = $service_enable ? { /^(undef|)$/ => undef,
                                             default => $service_enable }
  
  $unsupported_message = "This module does not support ${::osfamily} ${::operatingsystemrelease}"

  # configuration defaults
  case $osfamily {
    'RedHat': {
      case $operatingsystemrelease {
        /^6\.[0-9]+$/: { 
          $nagios_cfg = '/etc/nagios/nagios.cfg' 
          $cgi_cfg = '/etc/nagios/cgi.cfg'
          $service = 'nagios'
          $package = 'nagios'
          $check_result_path_default = '/var/log/nagios/spool/checkresults'
          $check_result_reaper_frequency_default = '10'
          $object_cache_file_default = '/var/log/nagios/objects.cache'
          $precached_object_file_default = '/var/log/nagios/objects.precache'
          $status_file_default='/var/log/nagios/status.dat'
          $temp_file_default='/var/log/nagios/nagios.tmp'
          $temp_path_default='/tmp'
        }
        default: { fail($unsupported_message) } } }
    default: {
      fail($unsupported_message) } 
  }


  # do we use the defaults or user supplied?
  $check_result_path_real = $check_result_path ? {
    /^(undef|)$/ => $check_result_path_default,
    default      => $check_result_path }
  $check_result_reaper_frequency_real = $check_result_reaper_frequency ? {
    /^(undef|)$/ => $check_result_reaper_frequency_default,
    default      => $check_result_reaper_frequency }
  $object_cache_file_real = $object_cache_file ? {
    /^(undef|)$/ => $object_cache_file_default,
    default      => $object_cache_file }
  $precached_object_file_real = $precached_object_file ? {
    /^(undef|)$/ => $precached_object_file_default,
    default      => $precached_object_file }
  $status_file_real = $status_file ? {
    /^(undef|)$/ => $status_file_default,
    default      => $status_file }
  $temp_file_real = $temp_file ? {
    /^(undef|)$/ => $temp_file_default,
    default      => $temp_file }
  $temp_path_real = $temp_path ? {
    /^(undef|)$/ => $temp_path_default,
    default      => $temp_path }

  # validate its all sane
  validate_absolute_path( $check_result_path_real )
  validate_absolute_path( $object_cache_file_real )
  validate_absolute_path( $precached_object_file_real )
  validate_absolute_path( $status_file_real )
  validate_absolute_path( $temp_file_real )
  validate_absolute_path( $temp_path_real )

  include nagios::package, nagios::config, nagios::service
  Class['nagios'] -> Class['nagios::config'] ~> Class['nagios::service']
}
