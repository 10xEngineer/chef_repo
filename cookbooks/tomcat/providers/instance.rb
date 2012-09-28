action :create do
	app_home = "/opt/java_apps"
	instance_home = ::File.join(app_home, new_resource.name)

	# TODO instance variable (from new_resource and defaults)
	#      java version
	#      
	# TODO port numbering (implicit/explicit)
	#      implicit 8005, 8009, 8080, 8443
	#               8105, 8109, 8180, 8543
	#               8205, 8209, 8280, 8643
	# TODO how to keep the same port numbers within a cluster

	instance_dirs = {
		"/bin" => {:user_access => false},
		"/conf" => {:user_access => false},
		"/webapps" => {:user_access => false},
		"/log" => {:user_access => true},
		"/temp" => {:user_access => true},
		"/work" => {:user_access => true},
	}

	# FIXME log temp work need user level access
	instance_dirs.keys.each do |instance_dir|
		a_dir = ::File.join(instance_home, instance_dir)

		directory a_dir do
			# TODO what user/group
			if instance_dirs[instance_dir][:user_access]
				user new_resource.user
				group new_resource.group
			else
				user "root"
				group "root"
			end

			mode 0755
			recursive true

			action :create
		end
	end


	# FIXME source packages from the cookbook (for everride)
	# FIXME 
	set_env_sh = ::File.join(instance_home, "bin/setenv.sh")
	template set_env_sh do
		source "setenv.sh.erb"

		cookbook "tomcat"

		user "root"
		group "root"

		mode "0644"

		action :create
	end

	# conf files (dynamically rendered)
	conf_dir = ::File.join(instance_home, "conf")
	%w{catalina.properties server.xml}.each do |cf|
		conf_file = ::File.join(conf_dir, cf)
		template conf_file do
			source "#{cf}.erb"

			cookbook "tomcat"

			user "root"
			group "root"
			mode "0644"

			action :create
		end
	end

	# static conf files
	%w{catalina.policy context.xml logging.properties tomcat-users.xml web.xml}.each do |cf|
		conf_file = ::File.join(conf_dir, cf)
		cookbook_file conf_file do
			source cf

			cookbook "tomcat"

			user "root"
			group "root"
			mode "0644"

			action :create
		end
	end

  	# TODO tomcat service	
end