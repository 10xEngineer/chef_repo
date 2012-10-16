# zfs::default

package "python-software-properties" do
  action :install
end

# add-apt-repository ppa:zfs-native/stable
apt_repository "zfs-native" do
  uri node["zfs"]["repository"]
  distribution node['lsb']['codename']
  components ["main"]

  keyserver node['zfs']['keyserver']
  key node['zfs']['key']

  action :add

  notifies :run, "execute[apt-get update]", :immediately
end

node["zfs"]["packages"].each do |pkg|
	package pkg do
		action :install
	end
end