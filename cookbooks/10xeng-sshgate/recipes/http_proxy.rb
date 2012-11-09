# 10xeng-sshgate::http_proxy

group "labsys" do
	gid 1666
end

# microcloud user
user "labsys" do
  comment "Labs System user"
  uid 1666
  gid "labsys"
  home "/home/labsys"
  shell "/bin/bash"
  password "$1$zq8LgADX$kIKNNFfUPCgF.JnJd.cl21"
  supports :manage_home => true
end

cookbook_file "/var/cache/10xlabs-gateway_#{node["http_proxy"]["version"]}_all.deb" do
	source "10xlabs-gateway_#{node["http_proxy"]["version"]}_all.deb"

	owner "root"
	group "root"

	mode 0644

	action :create
end

package "10xlabs-gateway" do
	source "/var/cache/10xlabs-gateway_#{node["http_proxy"]["version"]}_all.deb"

	provider Chef::Provider::Package::Dpkg

	action :install
end

directory "/etc/10xlabs/" do
	owner "root"
	group "root"

	mode 0755

	action :create
end

template "/etc/10xlabs/gateway.json" do
	source "gateway.json.erb"

	owner "root"
	group "root"

	mode 0644

	action :create
end

runit_service "http_proxy"

service "http_proxy" do
  supports :status => true, :restart => true, :reload => true
  action [ :restart ]
end
