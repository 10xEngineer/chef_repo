# tomcat::default

tomcat_version = node["tomcat"]["version"]

remote_file "/tmp/apache-tomcat-dist.tar.gz" do
	source node["tomcat"]["sources"][tomcat_version][:download_url]
	mode "0644"
	checksum node["tomcat"]["sources"][tomcat_version][:checksum]

	notifies :run, "script[install_tomcat]", :immediately
end

script "install_tomcat" do
	interpreter "bash"
	user "root"
	cwd "/tmp"
	code <<-EOH
	tar xvfz /tmp/apache-tomcat-dist.tar.gz -C /usr/local
	EOH

	action :nothing
end

