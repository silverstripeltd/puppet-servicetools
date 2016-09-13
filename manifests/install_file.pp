define servicetools::install_file (
	$source,
	$target = undef,
	$mode = "0755",
	$owner = "root",
	$group = "root"
) {
	if $target == undef {
		$real_target = $name
	} else {
		$real_target = $target
	}

	exec { "download_${name}":
		cwd => "/var/tmp",
		command => "/usr/bin/wget ${source} -O ${real_target}",
		creates => $real_target
	} -> file { $real_target:
		mode => $mode,
		owner => $owner,
		group => $group
	}
}
