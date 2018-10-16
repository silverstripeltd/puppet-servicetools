# Puppet Servicetools

Provides resources for standardised installation of arbitrary binaries, including daemonising them through systemd.
Designed to work well with hiera - you can install binaries without needing to write custom puppet manifests.

## Hiera usage

To improve composability, the module does NOT make assumptions on how your keys are named in hiera, and does not
`create_resources` for you. Map the resources to hiera keys:

	create_resources(servicetools::install_file, hiera('servicetools::install_file', {}))
	create_resources(servicetools::install_localfile, hiera('servicetools::install_localfile', {}))
	create_resources(servicetools::install_deb, hiera('servicetools::install_deb', {}))
	create_resources(servicetools::install_tgz, hiera('servicetools::install_tgz', {}))
	create_resources(servicetools::install_systemd_unit, hiera('servicetools::install_systemd_unit', {}))

Now you can use hiera to provision arbitrary resources:

	servicetools::install_tgz:
	  "/usr/local/bin/discombobulator":
		source: "https://github.com/reticulant/discombobulator/releases/download/0.1/discombobulator_0.1_linux_amd64.tar.gz"
	servicetools::install_systemd_unit:
	  "discombobulator":
		service_options:
		  ExecStart: "/usr/local/bin/discombobulator --reticulate-splines --calibrate-blue-skies"
		  Restart: "on-failure"
		  RestartSec: "5"
		service_ensure: "stopped"
		service_enable: true

## Running tests

Change directory to the project root, then run `bundle exec rake spec SPEC_OPTS='--format documentation'`