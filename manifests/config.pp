# == Class: nagios::config
#
# This class utilizes parameters passed into the nagios class, and uses them to
# configure nagios.
#
# == Notes:
#
# This class cannot be called on its own, and is intended to be called by the
# nagios master class.
class nagios::config {
  # EXPAND ARRAYS
  # Below we ensure that any values the erb template expects as an array
  # is in fact an array

  # TODO: Better validation that these are cfg files
  if ! is_array( $nagios::cfg_dir ) { 
    $cfg_dir_arr = split( $nagios::cfg_dir, ',' ) }
  else { $cfg_dir_arr = $nagios::cfg_dir }

  # TODO: Better validation that these are cfg dirs
  if ! is_array( $nagios::cfg_file ) { 
    $cfg_file_arr = split( $nagios::cfg_file, ',' ) }
  else { $cfg_file_arr = $nagios::cfg_file }

  # TODO: Better validation that these are all paths
  if ! is_array( $nagios::resource_file ) { 
    $resource_file_arr = split( $nagios::resource_file, ',' ) }
  else { $resource_file_arr = $nagios::resource_file }

  $enable_notifications = 
    any2bool( $nagios::enable_notifications ) ? { true => '1', default => '0' }
  $enable_event_handlers = 
    any2bool( $nagios::enable_event_handlers ) ? { true => '1', default => '0' }

  $authorized_for_system_information =
    is_array($nagios::authorized_for_system_information) ? {
      true => join($nagios::authorized_for_system_information, ','),
      false=> $nagios::authorized_for_system_information }

  $authorized_for_configuration_information =
    is_array($nagios::authorized_for_configuration_information) ? {
      true => join($nagios::authorized_for_configuration_information, ','),
      false=> $nagios::authorized_for_configuration_information }

  $authorized_for_system_commands =
    is_array($nagios::authorized_for_system_commands) ? {
      true => join($nagios::authorized_for_system_commands, ','),
      false=> $nagios::authorized_for_system_commands }
  $authorized_for_all_services =
    is_array($nagios::authorized_for_all_services) ? {
      true => join($nagios::authorized_for_all_services, ','),
      false=> $nagios::authorized_for_all_services }

  $authorized_for_all_hosts =
    is_array($nagios::authorized_for_all_hosts) ? {
      true => join($nagios::authorized_for_all_hosts, ','),
      false=> $nagios::authorized_for_all_hosts }

  $authorized_for_all_service_commands =
    is_array($nagios::authorized_for_all_service_commands) ? {
      true => join($nagios::authorized_for_all_service_commands, ','),
      false=> $nagios::authorized_for_all_service_commands }

   $authorized_for_all_host_commands =
     is_array($nagios::authorized_for_all_host_commands) ? {
      true => join($nagios::authorized_for_all_host_commands, ','),
      false=> $nagios::authorized_for_all_host_commands }

  # Variables in use by template
  #
  # @enable_event_handlers
  # @enable_notifications
  # @resource_file_arr
  # @cfg_file_arr
  # @cfg_dir_arr
  # @object_cache_file_real
  # @precached_object_file_real
  # @status_file_real
  # @temp_file_real
  # @temp_path_real
  # @check_result_path_real
  # @admin_email
  # @admin_pager
  # @check_result_reaper_frequency
  #
  file { $nagios::nagios_cfg:
    ensure  => 'file',
    owner   => 'nagios',
    group   => 'nagios',
    mode    => '0444',
    content => template('nagios/nagios.cfg.erb'),
    notify  => Class['nagios::service'],
  }

  file { $nagios::cgi_cfg:
    ensure  => 'file',
    owner   => 'nagios',
    group   => 'nagios',
    mode    => '0444',
    content => template('nagios/cgi.cfg.erb'),
    notify  => Class['nagios::service'],
  }

  file { $nagios::check_result_path_real:
    ensure => 'directory',
    owner  => 'nagios',
    group  => 'nagios',
    mode   => '0770',
  }

  file { $nagios::temp_path_real:
    ensure => 'directory',
  }

  $nagios_files = [ $nagios::object_cache_file_real,
                    $nagios::precached_object_file_real,
                    $nagios::status_file_real ]

  file { $nagios_files:
    ensure  => 'file',
    owner   => 'nagios',
    group   => 'nagios',
    mode    => '644',
    replace => false,
  }
}
