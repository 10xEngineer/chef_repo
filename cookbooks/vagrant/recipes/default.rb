# vagrant::default

gem_package "vagrant" do
	action :install

	version node['vagrant']['version']
end