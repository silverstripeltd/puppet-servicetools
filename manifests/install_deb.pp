define servicetools::install_deb (
	$source,
	$package_ensure = "latest"
) {
	$temp_file = "/var/tmp/${name}"

	exec { "download_${name}":
		cwd => "/var/tmp",
		command => "/usr/bin/wget ${source} -O ${temp_file}",
		creates => $temp_file
	} -> package { $name:
		provider => dpkg,
		ensure => $package_ensure,
		source => $temp_file
	}
}
