# 10xlab-compnode::default
#
# TODO add filesystem quota

package "curl" do
	action :install
end

package "git" do
	action :install
end

gem_package "bundle" do
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

template "/etc/10xlabs-compile.json" do
	source "10xlabs-compile.json.erb"

	owner "root"
	group "root"

	mode 0644

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

user "compile" do
  comment "10xLabs compile service user"
  uid 1667
  gid "users"
  home "/home/compile"
  shell "/bin/sh"
  password "$1$n1NZCRfR$9nERbvjfw0EXRe4PrmBAi0"
  supports :manage_home => true
end

directory "/home/compile/.ssh" do
  action :create
  owner "compile"
  group "users"
  mode 0700
end

cookbook_file "/home/compile/.ssh/authorized_keys" do
  source "authorized_keys"
  owner "compile"
  group "users"
  mode 0600
end

cookbook_file "/home/compile/wrap-ssh4git.sh" do
  source "wrap-ssh4git.sh"
  owner "compile"
  mode 0755
end

cookbook_file "/home/compile/.ssh/id_rsa" do
  source "mchammer-dev"
  owner "compile"
  group "users"
  mode 0600
end
