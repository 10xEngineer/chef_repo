# 10xEngineer Chef Repository

Cookbook and roles for the 10xEngineer infrastructure. The repository should be included as GIT submodule within individual projects.

## Bootstrap scripts

Individiual bootstrap scripts expect preconfigured SSH config

	Host viper
	  ForwardAgent yes
	  HostName viper.eu-1-aws.int.10xlabs.net

	Host gpi01
	  ForwardAgent yes
	  ProxyCommand ssh viper nc -q0 %h 22

and `10xeng-prod` key available in SSH agent.

Check out complete microcloud/chef repository and run

		cd chef_repo
		./gpi01_bootstrap.sh

Enjoy.
