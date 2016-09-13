define servicetools::install_tgz (
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

	$target_parent_path = dirname($real_target)
	$filename = basename($source)
	$temp_file = "/var/tmp/${filename}"

	exec { "download_${filename}":
		cwd => "/var/tmp",
		command => "/usr/bin/wget ${source} -O ${temp_file}",
		creates => $real_target
	} -> exec { "unpack_${filename}":
		cwd => "/var/tmp",
		command => "/bin/tar zxvf ${temp_file} -C ${target_parent_path}",
		creates => $real_target
	} -> file { $real_target:
		mode => $mode,
		owner => $owner,
		group => $group
	}
}
