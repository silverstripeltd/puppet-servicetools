define servicetools::install_systemd_unit (
	$unit_options = {},				# Arguments to pass to the systemd [Unit] section of template
	$service_options = {},			# Arguments to pass to the systemd [Service] section of template
	$install_options = {},			# Arguments to pass to the systemd [Install] section of template
	$service_ensure = "running",	# State of the service after installed
	$service_enable = true			# Enabled state of the service after installed
) {

	::systemd::unit_file { "${name}.service":
		content => template("${module_name}/systemd_service.erb")
	} -> service { $name:
		ensure => $service_ensure,
		enable => $service_enable
	}
}
