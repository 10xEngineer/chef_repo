# ovs::default

%w{ubuntu-dev-tools git vim libssl-dev autoconf libtool linux-headers-virtual}.each do |pkg|
	package pkg do
		action :install
	end
end

remote_file "/tmp/openvswitch-#{node["ovs"]["version"]}.tar.gz" do
	source node["ovs"]["distribution"]
	mode 0644
end

cookbook_file /tmp/0001-Fixes-for-Labs-on-Quantal.patch" do
	source "0001-Fixes-for-Labs-on-Quantal.patch"
end

bash "build_ovs" do
	user "root"
	cwd "/tmp"
	code <<-EOH
		tar xvfz openvswitch-#{node["ovs"]["version"]}.tar.gz
		cd openvswitch-#{node["ovs"]["version"]}
		./boot.sh
		./configure --with-linux=/lib/modules/`uname -r`/build
		patch -p1 <../0001-Fixes-for-Labs-on-Quantal.patch
		make
		make install
		cd datapath/linux
		make modules_install
	EOH
end

