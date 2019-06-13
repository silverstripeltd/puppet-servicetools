define servicetools::install_systemd_unit (
	$unit_options = {},						# Arguments to pass to the systemd [Unit] section of template
	$service_options = {},					# Arguments to pass to the systemd [Service] section of template
	$install_options = {},					# Arguments to pass to the systemd [Install] section of template
	$timer_options = {},					# Arguments to pass to the systemd [Timer] section of the timer template
	$wantedby_target = "multi-user.target", # Value of WantedBy. Defaults to multi-user.target
	$service_ensure = "running",			# State of the service after installed
	$service_enable = true					# Enabled state of the service after installed
) {

	if $name =~ /^([A-Za-z0-9_-]+)(\.)(timer)$/ {
		$real_name = $name
		$timer_service = regsubst($real_name, '.timer', '.service', 'G')
		$service = ""
		$exec = "systemctl start ${real_name}"
	} elsif $name =~ /^([A-Za-z0-9_-]+)(\.)(service)$/ {
		$real_name = $name
		$service = regsubst($real_name, '.service', '', 'G')
		$exec = ""
	} else {
		$real_name = "${name}.service"
		$service = regsubst($real_name, '.service', '', 'G')
		$exec = ""
		notice("${name} does not include '.service' or '.timer', assuming '.service'")
	}

	::systemd::unit_file { "${real_name}":
		content => template("${module_name}/systemd_unit.erb"),
	}

	if !empty($service) {
		service { $service:
			ensure => $service_ensure,
			enable => $service_enable,
			require => Systemd::Unit_file["$real_name"],
		}
	}

	if !empty($exec) {
		exec { "systemctl_start_${real_name}":
			command => $exec,
			require => Systemd::Unit_file["$real_name"],
			subscribe => Systemd::Unit_file["$real_name"],
			refreshonly => true,
			path => ["/bin", "/usr/bin/", "/usr/sbin"],
		}
	}
}
