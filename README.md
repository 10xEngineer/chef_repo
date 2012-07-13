# 10xEngineer Chef Repository

Cookbook and roles for the 10xEngineer infrastructure. The repository should be included as GIT submodule within individual projects.

## Microcloud Bootstrat

Check out complete microcloud/chef repository and run

		cd chef_repo
		export TARGET=ec2-hostname-where-to-install
		./mc_bootstrap

To get log from individual services use

	cd /etc/sv
	tail -f */log/main/current

Enjoy.
