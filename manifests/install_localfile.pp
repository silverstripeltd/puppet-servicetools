define servicetools::install_localfile (
	$source = undef,
	$content = undef,
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

	file { $real_target:
		source => $source,
		content => $content,
		mode => $mode,
		owner => $owner,
		group => $group
	}
}
