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
# [*process_performance_data*]
#   Should we process performance data? Defaults to false.
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
#
# [*service_perfdata_file*]
#   service performance data file
#
# [*service_perfdata_file_template*]
# [*service_perfdata_file_mode*]
# [*service_perfdata_file_processing_interval*]
# [*service_perfdata_file_processing_command*]
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
  $admin_email = hiera( 'nagios::admin_email', $nagios::params::admin_email ),
  $admin_pager = hiera( 'nagios::admin_pager', $nagios::params::admin_pager ),
  $authorized_for_all_hosts = hiera( 'nagios::authorized_for_all_hosts', [ 'nagiosadmin' ] ),
  $authorized_for_all_host_commands = hiera( 'nagios::authorized_for_all_host_commands', [ 'nagiosadmin' ] ),
  $authorized_for_all_services = hiera( 'nagios::authorized_for_all_services', [ 'nagiosadmin' ] ),
  $authorized_for_all_service_commands = hiera( 'nagios::authorized_for_all_service_commands', [ 'nagiosadmin' ] ),
  $authorized_for_configuration_information = hiera( 'nagios::authorized_for_configuration_information', [ 'nagiosadmin' ] ),
  $authorized_for_system_information = hiera( 'nagios::authorized_for_system_information', [ 'nagiosadmin' ] ),
  $authorized_for_system_commands = hiera( 'nagios::authorized_for_system_commands', [ 'nagiosadmin' ] ),
  $cfg_dir = hiera( 'nagios::cfg_dir', $nagios::params::cfg_dir ),
  $cfg_file = hiera( 'nagios::cfg_file', $nagios::params::cfg_file ),
  $check_result_path = hiera( 'nagios::check_result_path', $nagios::params::check_result_path ),
  $check_result_reaper_frequency = hiera( 'nagios::check_result_reaper_frequency', $nagios::params::check_result_reaper_frequency ),
  $enable_event_handlers = hiera( 'nagios::enable_event_handlers', $nagios::params::enable_event_handlers ),
  $enable_notifications = hiera( 'nagios::enable_notifications', $nagios::params::enable_notifications ),
  $host_perfdata_file = hiera( 'nagios::host_perfdata_file', '' ),
  $object_cache_file = hiera( 'nagios::object_cache_file', $nagios::params::object_cache_file ),
  $precached_object_file = hiera( 'nagios::precached_object_file', $nagios::params::precached_object_file ),
  $process_performance_data = hiera( 'nagios::process_performance_data', $nagios::params::process_performance_data ),
  $resource_file = hiera( 'nagios::resource_file', $nagios::params::resource_file ),
  $service_ensure = hiera( 'nagios::service_ensure', $nagios::params::service_ensure ),
  $service_enable = hiera( 'nagios::service_enable', $nagios::params::service_enable ),
  $service_perfdata_file = hiera( 'nagios::service_perfdata_file', '' ),
  $service_perfdata_file_template = hiera( 'nagios::service_perfdata_file_template', '' ),
  $service_perfdata_file_mode = hiera( 'nagios::service_perfdata_file_mode', '' ),
  $service_perfdata_file_processing_interval = hiera( 'nagios::service_perfdata_file_processing_interval', '' ),
  $service_perfdata_file_processing_command = hiera( 'nagios::service_perfdata_file_processing_command', '' ),
  $status_file = hiera( 'nagios::status_file', $nagios::params::status_file ),
  $temp_file = hiera( 'nagios::temp_file', $nagios::params::temp_file ),
  $temp_path = hiera( 'nagios::temp_path', $nagios::params::temp_path ),
) inherits nagios::params {

  $service_ensure_real = $service_ensure ? { /^(undef|)$/ =>  undef,
                                              default => $service_ensure }
  $service_enable_real = $service_enable ? { /^(undef|)$/ => undef,
                                              default => $service_enable }

  $unsupported_message = "This module does not support ${::osfamily} ${::operatingsystemrelease}"

  # configuration defaults
  case $::osfamily {
    'RedHat': {
      case $::operatingsystemrelease {
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
