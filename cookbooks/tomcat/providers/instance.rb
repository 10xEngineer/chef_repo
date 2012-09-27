action :create do
	# FIXME configurable
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

	%w{bin/ webapps/ log/ temp/ work/}.each do |instance_dir|
		a_dir = ::File.join(instance_home, instance_dir)

		directory a_dir do
			# TODO what user/group
			user "root"
			group "root"

			mode 0755
			recursive true

			action :create
		end
	end

	set_env_sh = ::File.join(app_home, "bin/setenv.sh")
	template set_env_sh do
		source "setenv.sh.erb"

		user "root"
		group "root"

		mode "0644"

		action :create

		notifies :create, "ruby_bloc[copy_conf]", :immediately
	end

	# copy $TOMCAT_HOME/conf into $instance/conf only first time
	# TODO provider cookbook_files
	# TODO check diffs between versions 5/6/7
	ruby_block "copy_conf" do
  		block do
  			command = "cp -R #{tomcat_home}/conf #{instance_home}/"

			batch = Chef::Resource::Script::Bash.new "copy_conf_script", run_context
			batch.code command
			batch.run_action(:run)
  		end

  		action :nothing
  	end

  	server_xml = ::File.join(instance_home, "conf/server.xml")
  	template "server_xml" do
  		source "server.xml.erb"

  		path server_xml

  		user "root"
  		group "root"
  		mode "0644"

  		action :create
  	end

  	# TODO tomcat service
end