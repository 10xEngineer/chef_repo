# 10xlab-compnode::default
#
# TODO add filesystem quota

package "curl" do
	action :install
end

package "git" do
	action :install
end

group node["10xlab"]["compnode"]["sandbox_group"] do
	gid node["10xlab"]["compnode"]["sandbox_gid"]
end

directory node["10xlab"]["compnode"]["home_location"] do
	owner "root"
	group node["10xlab"]["compnode"]["sandbox_group"]
	mode 0755

	action :create
end

packages = []
packages << "10xlabs-compile-service_#{node["10xlab"]["compnode"]["version"]}"
node["10xlab"]["compnode"]["compile_kits"].each do |kit|
	packages << "#{kit}"
end

packages.each do |pkg|
	cookbook_file "/var/cache/#{pkg}.deb" do
		source "#{pkg}.deb"

		owner "root"
		mode "0644"
	end

	package pkg do
		source "/var/cache/#{pkg}.deb"

		provider Chef::Provider::Package::Dpkg

		action :install
	end
end

# TODO create mchammer user
# TODO add it to sudoers
# TODO deploy 10xlabs-compile-server 
# TODO deploy individual compile_kits