# 10xeng-node::http_proxy

cookbook_file "/var/cache/10xlabs-httproxy_#{node["http_proxy"]["version"]}_all.deb" do
	source "10xlabs-httproxy_#{node["http_proxy"]["version"]}_all.deb"

	owner "root"
	group "root"

	mode 0644

	action :create
end

package "10xlabs-httproxy" do
	source "/var/cache/10xlabs-httproxy_#{node["http_proxy"]["version"]}_all.deb"

	provider Chef::Provider::Package::Dpkg

	action :install
end

runit_service "http_proxy"

service "http_proxy" do
  supports :status => true, :restart => true, :reload => true
  action [ :restart ]
end
